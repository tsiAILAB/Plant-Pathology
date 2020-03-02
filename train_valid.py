"""
Created on Mon Nov  07 09:11:29 2019
You can split into a training, testing and validation set.
A seed lets you reproduce the splits.
Works on any file types.
@author: Fakrul Islam

# Split with a ratio.
# To only split into training and validation set, set a tuple to `ratio`, i.e, `(.8, .2)`.
split_folders.ratio('input_folder', output="output", seed=1337, ratio=(.8, .1, .1))

# Split val/test with a fixed number of items e.g. 100 for each set.
# To only split into training and validation set, use a single number to `fixed`, i.e., `10`.
split_folders.fixed('input_folder', output="output", seed=1337, fixed=(100, 100), oversample=False) # default values

CLI
Usage:
    split_folders folder_with_images [--output] [--ratio] [--fixed] [--seed] [--oversample]
Options:
    --output     path to the output folder. defaults to `output`. Get created if non-existent.
    --ratio      the ratio to split. e.g. for train/val/test `.8 .1 .1` or for train/val `.8 .2`.
    --fixed      set the absolute number of items per validation/test set. The remaining items constitute
                 the training set. e.g. for train/val/test `100 100` or for train/val `100`.
    --seed       set seed value for shuffling the items. defaults to 1337.
    --oversample enable oversampling of imbalanced datasets, works only with --fixed.
Example:
    split_folders imgs --ratio .8 .1 .1

https://pypi.org/project/split-folders/

"""

import split_folders

# Split with a ratio.
split_folders.ratio('/home/fakrul/Documents/model/backup/input', output='/home/fakrul/Documents/model/backup/output', seed=1337, ratio=(.80, .20)) # 80%, 20%