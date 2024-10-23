
from pathlib import Path
import json


IS_TRAINING = False


def read_config() -> None:

    global IS_TRAINING

    with open(Path(__file__).parents[1] / 'etc/training.json', 'r') as fin:
        config = json.load(fin)

    IS_TRAINING = config['is_training']


read_config()
