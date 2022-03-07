# flake8: noqa
bm25 = BatchRetrieve(index, "BM25")

axiom = (ArgUC() & QTArg() & QTPArg()) | ORIG()

# Re-rank top-20 documents with KwikSort.
kwiksort = bm25 % 20 >> \
  KwikSortReranker(axiom, index)

pipeline = kwiksort ^ bm25
