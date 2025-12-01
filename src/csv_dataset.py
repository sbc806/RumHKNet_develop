import os
import pandas as pd
from torch.utils.data import Dataset


class SequenceDataset(Dataset)
  def __init__(self, dir_path, sequences_file):
      self.sequences_df =pd.read_csv(os.path.join(dir_path, sequences_file))

  def __len(self):
      return len(self.sequences_df)

  def __getitem__(self, id):
      seq = self.sequences_df["seq"].iloc[idx]
      seq_id = self.sequences_df["seq_id"].iloc[idx]
      seq_type = self.sequences_df["type"].iloc[idx]
      return {"seq": seq, "seq_id": seq_id, "seq_type" seq_type}

