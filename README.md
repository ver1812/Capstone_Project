# LLM-PIDS: Prompt Injection Detection System

Code and experimental artefacts for the paper LLM-PIDS: Prompt Classification for Detection and Mitigation of Prompt Injection Attacks.

LLM-PIDS is a model-agnostic proxy layer that categorises the incoming requests prior to sending them to the underlying LLM model without requiring any knowledge of the model's weights, hidden states, or system prompt. The accompanying study conducts an experiment that compares three classification approaches: conventional machine learning, deep learning from scratch, and transfer learning, using identical data partitions, class weighting, and evaluation procedures, and additionally examines cross-attack generalisation and resistance to encoding-level evasion.

Headline findings: ModernBERT-base performed best in terms of detection performance (F1 = 0.9473, ROC-AUC = 0.9854) with 20.2 ms of processing per query, compared to the F1 of 0.9098 and 1.0 ms from a baseline of TF-IDF LinearSVC. The model trained only on direct injections failed to generalise to indirect injections (ROC-AUC 0.6131) until fine-tuned on both attack types.

Data, weights and result artefacts: https://zenodo.org/records/21998831



