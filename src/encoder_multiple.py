#!/usr/bin/env python
# encoding: utf-8
'''
@license: (C) Copyright 2021, Hey.
@author: Hey
@email: sanyuan.hy@alibaba-inc.com
@tel: 137****6540
@datetime: 2023/4/21 16:10
@project: LucaPCycle
@file: encoder
@desc: encoder
'''
import os
import torch
import sys
import numpy as np
from esm import pretrained
sys.path.append(".")
sys.path.append("..")
sys.path.append("../src")
try:
    from llm.esm.predict_embedding import predict_embedding as predict_embedding_esm
    from llm.esm.predict_embedding import predict_embedding_multiple as predict_embedding_esm_multiple
    from utils import calc_emb_filename_by_seq_id
except ImportError as e:
    from src.llm.esm.predict_embedding import predict_embedding as predict_embedding_esm
    from src.llm.esm.predict_embedding import predict_embedding_multiple as predict_embedding_esm_multiple
    from src.utils import calc_emb_filename_by_seq_id


global_max_seq_len = 100000


def complete_embedding_matrix_esm(
        seq_id,
        seq_type,
        seq,
        truncation_seq_length,
        init_emb,
        trunc_type,
        embedding_type,
        matrix_add_special_token,
        embedding_complete,
        embedding_complete_seg_overlap,
        version,
        device
):
    if init_emb is not None and embedding_complete and ("representations" in embedding_type or "matrix" in embedding_type):
        torch.cuda.empty_cache()
        ori_seq_len = len(seq)
        # 每次能处理这么长度
        # print("init_emb:", init_emb.shape)
        cur_segment_len = init_emb.shape[0]
        if matrix_add_special_token:
            first_emb = init_emb[1:cur_segment_len - 1]
        else:
            first_emb = init_emb
        if matrix_add_special_token:
            cur_segment_len = cur_segment_len - 2
        # print("cur_segment_len: %d" % cur_segment_len)
        init_cur_segment_len = cur_segment_len
        segment_num = int((ori_seq_len + cur_segment_len - 1) / cur_segment_len)
        if segment_num <= 1:
            return init_emb
        append_emb = None
        if embedding_complete_seg_overlap:
            sliding_window = init_cur_segment_len // 2
            print("Embedding Complete Seg Overlap: %r, ori seq len: %d, segment len: %d, init sliding windown: %d" % (embedding_complete_seg_overlap,
                                                                                                                      ori_seq_len, init_cur_segment_len, sliding_window))
            while True:
                print("updated window: %d" % sliding_window)
                try:
                    # 第一个已经处理，滑动窗口
                    if trunc_type == "right":
                        last_end = init_cur_segment_len
                        seg_idx = 0
                        for pos_idx in range(init_cur_segment_len, ori_seq_len - sliding_window, sliding_window):
                            seg_idx += 1
                            last_end = min(pos_idx + sliding_window, ori_seq_len)
                            seg_seq = seq[pos_idx - sliding_window:last_end]
                            print("segment idx: %d, seg seq len: %d" % (seg_idx, len(seg_seq)))
                            seg_emb, seg_processed_seq_len = predict_embedding_esm(sample=[seq_id + "_seg_%d" % seg_idx, seq_type, seg_seq],
                                                                               trunc_type=trunc_type,
                                                                               embedding_type=embedding_type,
                                                                               repr_layers=[-1],
                                                                               truncation_seq_length=truncation_seq_length,
                                                                               device=device,
                                                                               version=llm_step,
                                                                               matrix_add_special_token=False
                                                                               )
                            # 有seq overlap 所以要截取
                            if append_emb is None:
                                append_emb = seg_emb[sliding_window:]
                            else:
                                append_emb = np.concatenate((append_emb, seg_emb[sliding_window:]), axis=0)
                        if last_end < ori_seq_len:
                            seg_idx += 1
                            remain = ori_seq_len - last_end
                            seg_seq = seq[ori_seq_len - 2 * sliding_window:ori_seq_len]
                            seg_emb, seg_processed_seq_len = predict_embedding_esm(sample=[seq_id + "_seg_%d" % seg_idx, seq_type, seg_seq],
                                                                               trunc_type=trunc_type,
                                                                               embedding_type=embedding_type,
                                                                               repr_layers=[-1],
                                                                               truncation_seq_length=truncation_seq_length,
                                                                               device=device,
                                                                               version=llm_step,
                                                                               matrix_add_special_token=False
                                                                               )
                            # 有seq overlap 所以要截取
                            if append_emb is None:
                                append_emb = seg_emb[-remain:]
                            else:
                                append_emb = np.concatenate((append_emb, seg_emb[-remain:]), axis=0)
                    else:
                        last_start = -init_cur_segment_len
                        seg_idx = 0
                        for pos_idx in range(-init_cur_segment_len, -ori_seq_len + sliding_window, -sliding_window):
                            seg_idx += 1
                            last_start = max(pos_idx - sliding_window, -ori_seq_len)
                            seg_seq = seq[last_start: pos_idx + sliding_window]
                            seg_emb, seg_processed_seq_len = predict_embedding_esm(sample=[seq_id + "_seg_%d" % seg_idx, seq_type, seg_seq],
                                                                               trunc_type=trunc_type,
                                                                               embedding_type=embedding_type,
                                                                               repr_layers=[-1],
                                                                               truncation_seq_length=truncation_seq_length,
                                                                               device=device,
                                                                               version=llm_step,
                                                                               matrix_add_special_token=False
                                                                               )
                            # 有seq overlap 所以要截取
                            if append_emb is None:
                                append_emb = seg_emb[:sliding_window]
                            else:
                                append_emb = np.concatenate((seg_emb[:sliding_window], append_emb), axis=0)
                        if last_start > -ori_seq_len:
                            seg_idx += 1
                            remain = last_start + ori_seq_len
                            seg_seq = seq[-ori_seq_len:-ori_seq_len + 2 * sliding_window]
                            seg_emb, seg_processed_seq_len = predict_embedding_esm(sample=[seq_id + "_seg_%d" % seg_idx, seq_type, seg_seq],
                                                                               trunc_type=trunc_type,
                                                                               embedding_type=embedding_type,
                                                                               repr_layers=[-1],
                                                                               truncation_seq_length=truncation_seq_length,
                                                                               device=device,
                                                                               version=llm_step,
                                                                               matrix_add_special_token=False
                                                                               )
                            # 有seq overlap 所以要截取
                            if append_emb is None:
                                append_emb = seg_emb[:remain]
                            else:
                                append_emb = np.concatenate((seg_emb[:remain], append_emb), axis=0)
                except Exception as e:
                    append_emb = None
                if append_emb is not None:
                    break
                print("fail, change sliding window: %d -> %d" % (sliding_window, int(sliding_window * 0.95)))
                sliding_window = int(sliding_window * 0.95)
        else:
            while True:
                print("ori seq len: %d, segment len: %d" % (ori_seq_len, cur_segment_len))
                try:
                    # 第一个已经处理，最后一个单独处理（需要向左/向右扩充至cur_segment_len长度）
                    if trunc_type == "right":
                        begin_seq_idx = 0
                    else:
                        begin_seq_idx = ori_seq_len - (segment_num - 1) * cur_segment_len
                    for seg_idx in range(1, segment_num - 1):
                        seg_seq = seq[begin_seq_idx + seg_idx * cur_segment_len: begin_seq_idx + (seg_idx + 1) * cur_segment_len]
                        # print("segment idx: %d, seg_seq(%d): %s" % (seg_idx, len(seg_seq), seg_seq))
                        print("segment idx: %d, seg seq len: %d" % (seg_idx, len(seg_seq)))
                        seg_emb, seg_processed_seq_len = predict_embedding_esm(
                            sample=[seq_id + "_seg_%d" % seg_idx, seq_type, seg_seq],
                            trunc_type=trunc_type,
                            embedding_type=embedding_type,
                            repr_layers=[-1],
                            truncation_seq_length=truncation_seq_length,
                            device=device,
                            version=llm_step,
                            matrix_add_special_token=False
                        )

                        if append_emb is None:
                            append_emb = seg_emb
                        else:
                            '''
                            if trunc_type == "right":
                                append_emb = np.concatenate((append_emb, seg_emb), axis=0)
                            else:
                                append_emb = np.concatenate((seg_emb, append_emb), axis=0)
                            '''
                            append_emb = np.concatenate((append_emb, seg_emb), axis=0)
                    if trunc_type == "right":
                        # 处理最后一个
                        last_seg_seq = seq[-cur_segment_len:]
                        really_len = (ori_seq_len - (segment_num - 1) * cur_segment_len)
                        # print("last seg seq: %s" % last_seg_seq)
                        print("last seg seq len: %d, really len: %d" % (len(last_seg_seq), really_len))
                        last_seg_emb, last_seg_processed_seq_len = predict_embedding_esm(
                            sample=[seq_id + "_seg_%d" % (segment_num - 1), seq_type, last_seg_seq],
                            trunc_type=trunc_type,
                            embedding_type=embedding_type,
                            repr_layers=[-1],
                            truncation_seq_length=truncation_seq_length,
                            device=device,
                            version=llm_step,
                            matrix_add_special_token=False
                        )
                        last_seg_emb = last_seg_emb[-really_len:, :]
                        append_emb = np.concatenate((append_emb, last_seg_emb), axis=0)
                    else:
                        # 处理第一个
                        first_seg_seq = seq[:cur_segment_len]
                        really_len = (ori_seq_len - (segment_num - 1) * cur_segment_len)
                        # print("first seg seq: %s" % first_seg_seq)
                        print("first seg seq len: %d, really len: %d" % (len(first_seg_seq), really_len))
                        first_seg_emb, first_seg_processed_seq_len = predict_embedding_esm(sample=[seq_id + "_seg_0", seq_type, first_seg_seq],
                                                                                       trunc_type=trunc_type,
                                                                                       embedding_type=embedding_type,
                                                                                       repr_layers=[-1],
                                                                                       truncation_seq_length=truncation_seq_length,
                                                                                       device=device,
                                                                                       version=llm_step,
                                                                                       matrix_add_special_token=False
                                                                                       )
                        first_seg_emb = first_seg_emb[:really_len, :]
                        append_emb = np.concatenate((first_seg_emb, append_emb), axis=0)
                except Exception as e:
                    append_emb = None
                if append_emb is not None:
                    break
                print("fail, change segment len: %d -> %d, change seg num: %d -> %d" % (cur_segment_len, int(cur_segment_len * 0.95), segment_num, int((ori_seq_len + cur_segment_len - 1) / cur_segment_len)))
                cur_segment_len = int(cur_segment_len * 0.95)
                segment_num = int((ori_seq_len + cur_segment_len - 1) / cur_segment_len)

            append_emb = append_emb[init_cur_segment_len - cur_segment_len:]
        if trunc_type == "right":
            complete_emb = np.concatenate((first_emb, append_emb), axis=0)
        else:
            complete_emb = np.concatenate((append_emb, first_emb), axis=0)
        print("seq len: %d, seq embedding matrix len: %d" % (ori_seq_len, complete_emb.shape[0] + (2 if matrix_add_special_token else 0)))
        print("-" * 50)
        assert complete_emb.shape[0] == ori_seq_len
        if matrix_add_special_token:
            complete_emb = np.concatenate((init_emb[0:1, :], complete_emb, init_emb[-1:, :]), axis=0)
        init_emb = complete_emb
    return init_emb


class EncoderMultiple(object):
    def __init__(self,
                 llm_type,
                 llm_step,
                 llm_dirpath,
                 input_type,
                 trunc_type,
                 seq_max_length,
                 prepend_bos=True,
                 append_eos=True,
                 vector_dirpath=None,
                 matrix_dirpath=None,
                 local_rank=-1,
                 use_cpu=False,
                 **kwargs):
        print("------EncoderMultiple------")
        self.llm_type = llm_type
        self.llm_step = llm_step
        self.llm_dirpath = llm_dirpath
        self.input_type = input_type
        self.trunc_type = trunc_type
        self.seq_max_length = seq_max_length
        # vector
        if vector_dirpath and "#" in vector_dirpath:
            self.vector_dirpath = list(vector_dirpath.split("#"))
        elif vector_dirpath:
            self.vector_dirpath = [vector_dirpath]
        else:
            self.vector_dirpath = None
        # matrix
        if matrix_dirpath and "#" in matrix_dirpath:
            self.matrix_dirpath = list(matrix_dirpath.split("#"))
        elif matrix_dirpath:
            self.matrix_dirpath = [matrix_dirpath]
        else:
            self.matrix_dirpath = None
        # special tokens
        self.prepend_bos = prepend_bos
        self.append_eos = append_eos

        self.matrix_add_special_token = False
        if "matrix_add_special_token" in kwargs and kwargs["matrix_add_special_token"]:
            self.matrix_add_special_token = kwargs["matrix_add_special_token"]

        print("Encoder: prepend_bos=%r, append_eos=%r" % (self.prepend_bos, self.append_eos))
        if self.matrix_add_special_token:
            self.prepend_bos = True
            self.append_eos = True

        if "embedding_complete" in kwargs and kwargs["embedding_complete"]:
            self.embedding_complete = kwargs["embedding_complete"]
            print("Encoder: embedding_complete=%r" % self.embedding_complete)
        else:
            self.embedding_complete = False
        if "embedding_complete_seg_overlap" in kwargs and kwargs["embedding_complete_seg_overlap"]:
            self.embedding_complete_seg_overlap = kwargs["embedding_complete_seg_overlap"]
            print("Encoder: embedding_complete_seg_overlap=%r" % self.embedding_complete_seg_overlap)
        else:
            self.embedding_complete_seg_overlap = False

        if "matrix_embedding_exists" in kwargs and kwargs["matrix_embedding_exists"]:
            self.matrix_embedding_exists = kwargs["matrix_embedding_exists"]
        else:
            self.matrix_embedding_exists = False

        print("Encoder version:", self.llm_step)
                     
        if local_rank == -1 and not use_cpu and torch.cuda.is_available():
            device = torch.device("cuda")
        elif torch.cuda.is_available() and local_rank > -1:
            device = torch.device("cuda", local_rank)
        else:
            device = torch.device("cpu")
        print("Encoder device: ", device)
        self.device = device
        self.seq_id_2_emb_filename = {}
        print("Encoder: prepend_bos=%r, append_eos=%r" % (self.prepend_bos, self.append_eos))
        print("Encoder: matrix_add_special_token=%r, "
              "embedding_complete=%r, "
              "embedding_complete_seg_overlap=%r, "
              "matrix_embedding_exists=%r" %
              (self.matrix_add_special_token,
               self.embedding_complete,
               self.embedding_complete_seg_overlap,
               self.matrix_embedding_exists)
              )
        print("-" * 50)

        global_model, global_alphabet = pretrained.load_model_and_alphabet("esm2_t36_3B_UR50D")
        if device is None:
            device = next(global_model.parameters()).device
        else:
            model_device = next(global_model.parameters()).device
            if device != model_device:
                global_model = global_model.to(device)
        self.global_model = global_model
        self.global_alphabet = global_alphabet
                     
    def __get_embedding_multiple__(self, seq_batch, embedding_type):
        # Expects seq_batch which
        # First column should be seq_id
        # Second column should be seq_type
        # Third column should be seq
        embedding_saved = False
        
        embedding_info = None
        
        if embedding_info is None:
            if self.llm_type == "esm":
                # seq_len = len(seq)
                seq_len = seq_batch["seq"].str.len().tolist()
                if self.embedding_complete:
                    truncation_seq_length = min(max(seq_len), global_max_seq_len)
                    # truncation_seq_length = np.minimum(seq_len, global_max_seq_len)
                else:
                    truncation_seq_length = self.seq_max_length - int(self.prepend_bos) - int(self.append_eos)
                    truncation_seq_length = min(max(seq_len), truncation_seq_length)
                    # truncation_seq_length = np.minimum(seq_len, truncation_seq_length)
                embedding_info, processed_seq_len, tokens = predict_embedding_esm_multiple(
                    seq_batch=seq_batch.copy(),
                    trunc_type=self.trunc_type,
                    embedding_type=embedding_type,
                    repr_layers=[-1],
                    truncation_seq_length=truncation_seq_length,
                    matrix_add_special_token=self.matrix_add_special_token,
                    version=self.llm_step,
                    device=self.device,
                    seq_len=seq_len,
                    global_model=self.global_model,
                    global_alphabet=self.global_alphabet
                )
                while embedding_info is None:
                    print("%s embedding error, max_len from %d truncate to %d" % (seq_id,
                                                                                  truncation_seq_length,
                                                                                  int(truncation_seq_length * 0.95)))
                    truncation_seq_length = (truncation_seq_length + int(self.prepend_bos) + int(self.append_eos)) * 0.95 \
                                            - int(self.prepend_bos) - int(self.append_eos)
                    truncation_seq_length = int(truncation_seq_length)
                    embedding_info, processed_seq_len = predict_embedding_esm(
                        sample=[seq_id, seq],
                        trunc_type=self.trunc_type,
                        embedding_type=embedding_type,
                        repr_layers=[-1],
                        truncation_seq_length=truncation_seq_length,
                        version=self.llm_step,
                        matrix_add_special_token=self.matrix_add_special_token,
                        device=self.device
                    )
                    if embedding_info is not None and self.embedding_complete:
                        embedding_info = complete_embedding_matrix_esm(
                            seq_id=seq_id,
                            seq_type=seq_type,
                            seq=seq,
                            truncation_seq_length=truncation_seq_length,
                            init_emb=embedding_info,
                            trunc_type=self.trunc_type,
                            embedding_type=embedding_type,
                            matrix_add_special_token=self.matrix_add_special_token,
                            embedding_complete=self.embedding_complete,
                            embedding_complete_seg_overlap=self.embedding_complete_seg_overlap,
                            version=self.llm_step,
                            device=self.device
                        )
            else:
                raise Exception("Not support the llm_type=%s" % self.llm_type)
        
        return embedding_info, tokens, seq_len

    def encode_multiple(self,
                      seq_batch,
                      label=None,
                      batch=None):

        # for embedding matrix
        matrix = None
        if self.input_type in ["matrix", "seq_matrix"]:
            # if matrix_filename is None:
                # if seq is None:
                    # raise Exception("seq is none and matrix_filename is none")
                # elif seq_type not in ["protein", "prot", "gene"]:
                    # raise Exception("now not support embedding of the seq_type=%s" % seq_type)
                # else:
                    # matrix = self.__get_embedding__(seq_id, seq_type, seq, "matrix")
            # elif isinstance(matrix_filename, str):
                # for matrix_dir in self.matrix_dirpath:
                    # matrix_filepath = os.path.join(matrix_dir, matrix_filename)
                    # if os.path.exists(matrix_filepath):
                        # matrix = torch.load(matrix_filepath)
                        # break
            # elif isinstance(matrix_filename, np.ndarray):
                # matrix = matrix_filename
            # else:
                # raise Exception("matrix is not filepath-str and np.ndarray")
            matrix, tokens, seq_len = self.__get_embedding_multiple__(seq_batch, "matrix")
            
        # seq = seq.strip().upper()
        seq_id = seq_batch["seq_id"].tolist()
        seq = seq_batch["seq"].str.strip().str.upper().tolist()
        seq_type = ["prot"] * len(seq_batch)
        vector = []
        label = []
        batch = []
        return {
            "seq_id": seq_id,
            "seq": seq,
            "seq_type": seq_type,
            "vector": vector,
            "matrix": matrix,
            "label": label,
            "batch": batch,
            "esm2_tokens": tokens,
            "seq_len": seq_len
        }

    




