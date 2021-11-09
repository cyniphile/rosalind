import numpy as np
from dataclasses import dataclass
from typing import List
import numpy.typing as npt
from bio_lib_py.bio_lib import *

import pytest
import bio_lib_string_rs


@pytest.fixture(scope="session")
def example_dna():
    with open('./data/rosalind_rna.txt') as f:
        dna = f.read().strip()
    return dna


@pytest.fixture(scope="session")
def example_dna_large():
    with open('./benchmark-data/rna-large.txt') as f:
        dna = f.read().strip()
    return dna


def test_transcribe(benchmark, example_dna):
    benchmark(transcribe_dna_to_rna, example_dna)


def test_transcribe_np(benchmark, example_dna):
    benchmark(transcribe_dna_to_rna_np, example_dna)


def test_rs_transcribe(benchmark, example_dna):
    benchmark(bio_lib_string_rs.transcribe_dna_to_rna, example_dna)


def test_rs_transcribe_builtin(benchmark, example_dna):
    benchmark(bio_lib_string_rs.transcribe_dna_to_rna_builtin, example_dna)


def test_transcribe_builtin(benchmark, example_dna):
    benchmark(transcribe_dna_to_rna_builtin, example_dna)


def test_transcribe_large(benchmark, example_dna_large):
    benchmark(transcribe_dna_to_rna, example_dna_large)


def test_transcribe_np_large(benchmark, example_dna_large):
    benchmark(transcribe_dna_to_rna_np, example_dna_large)


def test_rs_transcribe_large(benchmark, example_dna_large):
    benchmark(bio_lib_string_rs.transcribe_dna_to_rna, example_dna_large)


def test_rs_transcribe_builtin_large(benchmark, example_dna_large):
    benchmark(bio_lib_string_rs.transcribe_dna_to_rna_builtin, example_dna_large)


def test_transcribe_builtin_large(benchmark, example_dna_large):
    benchmark(transcribe_dna_to_rna_builtin, example_dna_large)
