# type: ignore
import numpy as np
from problems_py.stepik_2021.metabolite_annotation.helpers import minimize_all_deltas, setup_test
import os
import pytest


@pytest.mark.skip(reason="slow")
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


@pytest.mark.skip(reason="slow")
def test_1(rootdir):
    setup_test(
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/all2/1.txt'),
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/answer1.txt'),
        minimize_all_deltas,
        test=True
    )


@pytest.mark.skip(reason="slow")
def test_2(rootdir):
    setup_test(
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/all2/2.txt'),
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/answer2.txt'),
        minimize_all_deltas,
        test=False
    )


@pytest.mark.skip(reason="slow")
def test_3(rootdir):
    setup_test(
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/all2/3.txt'),
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/answer3.txt'),
        minimize_all_deltas,
        test=False
    )


@pytest.mark.skip(reason="slow")
def test_4(rootdir):
    setup_test(
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/all2/4.txt'),
        os.path.join(
            rootdir, '../problems_py/metabolite_annotation/answer4.txt'),
        minimize_all_deltas,
        test=False
    )
