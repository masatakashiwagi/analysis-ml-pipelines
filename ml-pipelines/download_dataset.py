import os
import pandas as pd

# Initial dataset source
DATASET_URL = "http://bit.ly/building-ml-pipelines-dataset"

# Initial local dataset location
BASE_DIR = "data/csv/"
LOCAL_FILE_NAME = BASE_DIR + "consumer_complaints_with_narrative.csv"


def download_dataset(url=DATASET_URL):
    """download_dataset downloads the remote dataset to a local path

    Keyword Arguments:
        url {string} --
            complete url path to the csv data source (default: {DATASET_URL})
        local_path {string} --
            initial local file location (default: {LOCAL_FILE_NAME})
    Returns:
        None
    """
    df = pd.read_csv(url, index_col=0)
    
    # ディレクトリが無ければ，作成する
    if not os.path.isdir(BASE_DIR):
        os.makedirs(BASE_DIR)
        
    df.to_csv(LOCAL_FILE_NAME)


if __name__ == '__main__':
    download_dataset(url=DATASET_URL)