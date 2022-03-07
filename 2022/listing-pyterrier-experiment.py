# flake8: noqa
experiment = AxiomaticExperiment(
  [bm25, monot5, ...],
  dataset.get_topics(),
  dataset.get_qrels(),
  index,
  axioms=[ArgUC(), QTArg(), QTPArg(), ...]
)

experiment.preferences
experiment.preference_distribution
experiment.preference_consistency
experiment.inconsistent_pairs
