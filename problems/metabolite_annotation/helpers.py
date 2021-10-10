import pandas as pd
import numpy as np
import math


def minimize_all_deltas(Ss, Ms, As):
    answers_dict = {}
    answers = []
    Mss = pd.Series(Ms).drop_duplicates().sort_values()
    Mssv = Mss.values
    Ass = pd.Series(As).drop_duplicates().sort_values(ascending=False)
    Assv = Ass.values
    print("Dups M:", (len(Ms) - len(Mss)) / len(Ms), "of", len(Ms))
    print("Dups A:", (len(As) - len(Ass)) / len(As), "of", len(As))
    print("Dups S:", (len(Ss) - len(pd.Series(Ss).drop_duplicates())) /
          len(Ss), "of", len(Ss))
    lMss = len(Mss)
    lAss = len(Ass)
    print(Mss.reset_index())
    print(Ass.reset_index())
    for s in Ss:
        if s not in answers_dict.keys():
            vals = best_delta_for_s(s, Mssv, Assv)
            vals = (Mss.index[vals[0]], Ass.index[vals[1]])
            answers_dict[s] = stringify_duple(vals)
        answers.append(answers_dict[s])
    return answers


def setup_test(test_file, answer_output_file, function, test=False):
    with open(test_file) as f:
        lines = f.readlines()
    with open(answer_output_file, 'r+') as a:
        test_count = int(lines[0])
        index = 1
        for i in range(test_count):
            Ms = np.array([np.int32(1e6 * float(m))
                          for m in lines[index+1].strip().split(" ")])
            As = np.array([np.int32(1e6 * float(a))
                          for a in lines[index+2].strip().split(" ")])
            Ss = np.array([np.int32(1e6 * float(s))
                          for s in lines[index+3].strip().split(" ")])
            # M, K, N = lines[index].split(" ")
            # assert(len(Ms) == int(M))
            # assert(len(As) == int(K))
            # assert(len(Ss) == int(N))
            answers = function(Ss, Ms, As)
            if not test:
                a.write("\n".join(answers) + "\n")
            index += 4
        if test:
            test_answer = "".join(a.readlines())
            assert "\n".join(answers) == test_answer


def stringify_duple(tup):
    return " ".join([str(e + 1) for e in tup])


def best_delta_for_s(s, Mssv, Assv):
    best_delta = 1e9
    i, j = 0, 0
    lMss = len(Mssv)
    lAss = len(Assv)
    while True:
        sigma = Mssv[i] + Assv[j]
        d = sigma - s
        a_d = abs(d)
        if a_d < best_delta and sigma > 0:
            best_delta = a_d
            vals = (i, j)
            if d == 0:
                return vals
        if i + 1 == lMss or j + 1 == lAss:
            return vals
        if d < 0:
            lMssRemain = lMss - (i + 1)
            while True:
                lMssRemain = math.ceil(lMssRemain / 2)
                if lMssRemain < 3:
                    if d < 0:
                        i += 1
                    else:
                        i -= 1
                else:
                    if d < 0:
                        i = i + lMssRemain
                    else:
                        i = i - lMssRemain
                if i == lMss - 1:
                    # return vals
                    break
                try:
                    sigma1 = Mssv[i] + Assv[j]
                except IndexError:
                    import pdb; pdb.set_trace()
                d = sigma1 - s
                sigma2 = Mssv[i - 1] + Assv[j]
                dd = sigma2 - s
                if d == 0:
                    vals = (i, j)
                    return vals
                if dd == 0:
                    vals = (i - 1, j)
                    return vals
                if d >= 0 and dd <= 0:
                    a_d = abs(dd)
                    if a_d < best_delta and sigma2 > 0:
                        best_delta = a_d
                        vals = (i - 1, j)
                    break
        else:
            lAssRemain = lAss - (j + 1)
            while True:
                lAssRemain = math.ceil(lAssRemain / 2)
                if lAssRemain < 3:
                    if d > 0:
                        j += 1
                    else:
                        j -= 1
                else:
                    if d >= 0:
                        j = j + lAssRemain
                    else:
                        j = j - lAssRemain
                if j == lAss - 1:
                    # return vals
                    break
                sigma1 = Mssv[i] + Assv[j]
                d = sigma1 - s
                sigma2 = Mssv[i] + Assv[j - 1]
                dd = sigma2 - s
                if d == 0 and sigma1 > 0:
                    vals = (i, j)
                    return vals
                if dd == 0 and sigma2 > 0:
                    vals = (i, j - 1)
                    return vals
                if d <= 0 and dd >= 0:
                    a_d = abs(dd)
                    if a_d < best_delta and sigma2 > 0:
                        best_delta = a_d
                        vals = (i, j - 1)
                    break
