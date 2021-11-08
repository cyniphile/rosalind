import numpy as np
from dataclasses import dataclass
from typing import List
import numpy.typing as npt

import pytest
import bio_lib_string_rs


@pytest.fixture(scope="session")
def example_data():
    with open('./data/rosalind_rna.txt') as f:
        dna = f.read().strip()
    return [dna]


def transcribeDNAtoRNA(string):
    return ''.join(["U" if char == 'T' else char for char in string])


def test_transcribe(benchmark, example_data):
    benchmark(transcribeDNAtoRNA, example_data)


def test_rs_transcribe(benchmark, example_data):
    benchmark(bio_lib_string_rs.transcribe_dna_to_rna, example_data)
