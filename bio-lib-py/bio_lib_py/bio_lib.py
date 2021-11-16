import numpy.typing as npt
import numpy as np
from dataclasses import dataclass
from typing import List
import bio_lib_string_rs
import pandas as pd


def split_sequences_to_columns(sequences: pd.Series) -> pd.DataFrame:
    """
    TODO: rather slow, research jax unirep
    """
    return sequences.apply(lambda x: pd.Series(list(x)))  # type: ignore


@dataclass
class PalindromeLocation:
    start_index: int
    length: int


def find_reverse_palindromes(seq: str) -> List[PalindromeLocation]:
    min_len = 4
    max_len = 12
    locations = []
    for i in range(0, len(seq) - min_len + 1):
        for length in range(min_len, max_len + 1, 2):
            if i + length > len(seq):
                continue
            test_seq = seq[i:(i + length)]
            if is_reverse_palindrome(test_seq):
                locations.append(
                    PalindromeLocation(start_index=i + 1, length=length)
                )
    return locations


def is_reverse_palindrome(seq: str) -> bool:
    return seq == reverse_complement_dna(seq)


def reverse_complement_dna(dna_seq: str) -> str:
    return ''.join([dna_base_complement(b) for b in dna_seq[::-1]])


def dna_base_complement(base: str) -> str:
    if base == "A":
        return "T"
    elif base == "T":
        return "A"
    elif base == "G":
        return "C"
    elif base == "C":
        return "G"
    else:
        raise Exception("Non-DNA base \"{}\" found.".format(base))


def transcribe_builtin(dna: str) -> str:
    return dna.replace("T", "U")


def transcribe(dna: str) -> str:
    return ''.join(["U" if char == 'T' else char for char in dna])


def transcribe_np(dna: str) -> str:
    return str(np.char.replace(dna, "T", "U"))  # type: ignore


def find_reverse_palindromes_rs(seq: str) -> List[PalindromeLocation]:
    ps = bio_lib_string_rs.find_reverse_palindromes(seq)  # type: ignore
    return [  # type: ignore
        PalindromeLocation(
            start_index=p.start_index,  # type: ignore
            length=p.length  # type: ignore
        )
        for p in ps  # type: ignore
    ]


def find_reverse_palindromes_np(seq: str) -> List[PalindromeLocation]:
    min_len = 4
    max_len = 12
    locations = []
    np_seq: npt.ArrayLike = np.array(list(seq))
    for i in range(0, len(np_seq) - min_len + 1):  # type: ignore
        for length in range(min_len, max_len + 1, 2):
            if i + length > len(np_seq):  # type: ignore
                continue
            test_seq = np_seq[i:(i + length)]  # type: ignore
            if is_reverse_palindrome_np(test_seq):  # type: ignore
                locations.append(
                    PalindromeLocation(start_index=i + 1, length=length)
                )
    return locations


def is_reverse_palindrome_np(seq: npt.ArrayLike) -> bool:
    reversed_complement = np.array(
        list(map(dna_base_complement, np.flip(seq))))  # type: ignore
    return np.array_equal(seq, reversed_complement)  # type: ignore
