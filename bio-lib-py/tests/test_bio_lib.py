import pandas as pd
from bio_lib_py.bio_lib import *


def test_split_sequences_to_columns():
    test_seqs = pd.Series(["aaa", "bbb"])
    result = split_sequences_to_columns(test_seqs)
    assert(result.shape == (2, 3))


def test_find_reverse_palindromes():
    seq = "TCAATGCATGCGGGTCTATATGCAT"
    test_answer = find_reverse_palindromes(seq)
    test_answer = [(p.start_index, p.length) for p in test_answer]
    true_answer = [
        (4, 6),
        (5, 4),
        (6, 6),
        (7, 4),
        (17, 4),
        (18, 4),
        (20, 6),
        (21, 4),
    ]
    assert true_answer == test_answer
