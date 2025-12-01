import os
import pandas as pd
from torch.utils.data import Dataset


class SequenceDataset(Dataset)
  def __init__(self, dir_path, sequences_file, trunc_type, truncation_seq_length):
      self.sequences_df = pd.read_csv(os.path.join(dir_path, sequences_file))

  def __len__(self):
      return len(self.sequences_df)

  def __getitem__(self, id):
      seq = self.sequences_df["seq"].iloc[idx]
      seq_id = self.sequences_df["seq_id"].iloc[idx]
      seq_type = self.sequences_df["type"].iloc[idx]
      if self.trunc_type == "left":
        seq_truncated = seq[-truncation_seq_length:]
      else:
        seq_truncated = seq[:truncation_seq_length]
      return {"transformer": [seq_id, seq], "esm": [seq_id, seq_truncated]}






