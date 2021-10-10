import numpy as np
from problems.metabolite_annotation.helpers import minimize_all_deltas, setup_test
import os
import pytest


def test_minimize_all_deltas():
    ts = [1]
    tMs = np.array([1, 3])
    tAs = np.array([1, 0])
    assert minimize_all_deltas(ts, tMs, tAs) == ['1 2']

# ts = [2]
# tMs = np.append([1], np.full(1000, 2))
# tAs = np.append([1], np.full(1000, 2))
# # will be slow without early stopping
# minimize_all_deltas(ts, tMs, tAs)


@pytest.fixture
def rootdir():
    return os.path.dirname(os.path.abspath(__file__))


def test_1(rootdir):
    setup_test(
        os.path.join(rootdir, '../problems/metabolite_annotation/all2/1.txt'),
        os.path.join(rootdir, '../problems/metabolite_annotation/answer1.txt'),
        minimize_all_deltas,
        test=True
    )

def test_2(rootdir):
    setup_test(
        os.path.join(rootdir, '../problems/metabolite_annotation/all2/2.txt'),
        os.path.join(rootdir, '../problems/metabolite_annotation/answer2.txt'),
        minimize_all_deltas,
        test=False
    )

def test_3(rootdir):
    setup_test(
        os.path.join(rootdir, '../problems/metabolite_annotation/all2/3.txt'),
        os.path.join(rootdir, '../problems/metabolite_annotation/answer3.txt'),
        minimize_all_deltas,
        test=False
    )


def test_4(rootdir):
    setup_test(
        os.path.join(rootdir, '../problems/metabolite_annotation/all2/4.txt'),
        os.path.join(rootdir, '../problems/metabolite_annotation/answer4.txt'),
        minimize_all_deltas,
        test=False
    )









