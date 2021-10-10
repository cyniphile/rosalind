best_delta = 1e9
i, j = 0, 0
while True:
    sigma = Mssv[i] + Assv[j]
     d = sigma - s
      a_d = abs(d)
       if a_d < best_delta and sigma > 0:
            best_delta = a_d
            vals = (i, j)
            if d == 0:
                break
        if i + 1 == lMss or j + 1 == lAss:
            break
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
                    break
                d = Mssv[i] + Assv[j] - s
                dd = Mssv[i - 1] + Assv[j] - s
                if d >= 0 and dd <= 0:
                    a_d = abs(dd)
                    if a_d < best_delta and sigma > 0:
                        best_delta = a_d
                        vals = (i - 1, j)
                        # refactor
                        if d == 0:
                            break
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
                    break
                d = Mssv[i] + Assv[j] - s
                dd = Mssv[i] + Assv[j - 1] - s
                # refactor
                if d == 0:
                    best_delta = d
                    vals = (i, j)
                    break
                if dd == 0:
                    best_delta = dd
                    vals = (i, j - 1)
                    break
                if d <= 0 and dd >= 0:
                    a_d = abs(dd)
                    if a_d < best_delta and sigma > 0:
                        best_delta = a_d
                        vals = (i, j - 1)
                    break
