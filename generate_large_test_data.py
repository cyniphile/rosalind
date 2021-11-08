from os.path import exists

if __name__ == "__main__":
    if not exists("./benchmark-data/revp-large.txt"):
        with open("./data/rosalind_revp.txt") as f:
            lines = f.readlines()
            data = "".join([l.strip() for l in lines[1:]])
        with open("./benchmark-data/revp-large.txt", 'a') as bf:
            for _ in range(100):
                bf.write(data)
    if not exists("./benchmark-data/rna-large.txt"):
        with open("./data/rosalind_rna.txt") as f:
            data = f.read().strip()
        with open("./benchmark-data/rna-large.txt", 'a') as bf:
            for _ in range(100):
                bf.write(data)
