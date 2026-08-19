# LLM-PIDS: Prompt Injection Detection System

Code and experimental artefacts for the paper LLM-PIDS: Prompt Classification for Detection and Mitigation of Prompt Injection Attacks.

LLM-PIDS is a model-agnostic proxy layer that categorises the incoming requests prior to sending them to the underlying LLM model without requiring any knowledge of the model's weights, hidden states, or system prompt. The accompanying study conducts an experiment that compares three classification approaches: conventional machine learning, deep learning from scratch, and transfer learning, using identical data partitions, class weighting, and evaluation procedures, and additionally examines cross-attack generalisation and resistance to encoding-level evasion.

Headline findings: ModernBERT-base performed best in terms of detection performance (F1 = 0.9473, ROC-AUC = 0.9854) with 20.2 ms of processing per query, compared to the F1 of 0.9098 and 1.0 ms from a baseline of TF-IDF LinearSVC. The model trained only on direct injections failed to generalise to indirect injections (ROC-AUC 0.6131) until fine-tuned on both attack types.

Data, weights and result artefacts: https://zenodo.org/records/21998831


---
 
## Repository structure
 
```
data/                     Dataset download, cleaning and corpus construction notebooks
evaluation/               Evaluation notebooks and their JSON/PNG output artefacts
models/                   Training notebooks for all eight Phase 1 models, plus fine-tuning
models/saved_v2/          Model configs, tokenisers and training artefacts (see Model weights)
models/Version1/          Superseded v1 corpus artefacts, retained for transparency
results/                  Consolidation notebook and the CSV tables reported in the paper
full_pipeline_demo.ipynb  End-to-end pipeline demonstration
```
 
---
 
## Setup
 
Requires Python 3.11.
 
```bash
conda env create -f environment.yml
conda activate llm-pids
```


The notebooks were developed and executed across three environments: local machine (CPU) for the conventional machine learning algorithms, Kaggle (NVIDIA T4) for the BiLSTM versions, and Colab (NVIDIA T4 for BERT-base and DistilBERT, NVIDIA A100 for ModernBERT-base). The evaluation notebooks have been run on a Colab A100 notebook to ensure consistent latencies between models.
 
### Configuring paths
 
The notebooks were written to run on Google Colab with Google Drive mounted, and read from and write to a `Capstone/` directory on Drive. Each notebook defines its input and output paths in a configuration cell near the top. To run them elsewhere, edit that cell to point at your local equivalents of:
 
- `Capstone/data_v2/` : the processed corpus splits
- `Capstone/saved/` : model weights
- `Capstone/eval/results/` : evaluation output
No other changes should be needed.
 
---

 
## Data
 
Four datasets are used. Two are gated on Hugging Face and require access approval before download.
 
| Dataset | Role | Link |
|---|---|---|
| `deepset/prompt-injections` | Direct injection, training corpus | [Hugging Face](https://huggingface.co/datasets/deepset/prompt-injections) |
| `allenai/wildjailbreak` (gated) | Adversarial jailbreak, training corpus | [Hugging Face](https://huggingface.co/datasets/allenai/wildjailbreak) |
| `ahsanayub/malicious-prompts` | Malicious/benign prompts, training corpus | [Hugging Face](https://huggingface.co/datasets/ahsanayub/malicious-prompts) |
| `MAlmasabi/Indirect-Prompt-Injection-BIPIA-GPT` (gated) | Indirect injection, held out from training | [Hugging Face](https://huggingface.co/datasets/MAlmasabi/Indirect-Prompt-Injection-BIPIA-GPT) |
 
The three training sources were merged and subsampled into a single corpus of 20,662 labelled prompts, split 70/15/15 with stratification and a fixed random seed of 42. The BIPIA-derived set was never included in training and was used only to evaluate generalisation to indirect injection.
 
The processed corpus is not committed to this repository. It is available from the Zenodo record linked above, and can also be regenerated from the source datasets using `data/new_data_exploration_cleaning_v2.ipynb`.

### Corpus versions
 
The corpus went through two iterations. Manual inspection of the first revealed that roughly 62% of rows labelled benign from one source were in fact HackAPrompt-style injection attempts. The corpus was rebuilt with corrected labels and every model retrained from scratch. **All results reported in the paper come from the corrected v2 corpus.** Artefacts carrying a `_v1` suffix, and everything under `models/Version1/`, belong to the first iteration and are retained only to show the correction.
 
---

### Model weights

Some weights and training artefacts are committed to this repository, but the set is incomplete: the traditional machine learning models are present in full, while for the BiLSTM and transformer models only the configurations, tokenisers, training histories and plots are included. The checkpoints themselves were too large to version here.

Use the Zenodo record instead. It contains everything needed to reproduce the reported evaluations: the processed corpus, all model weights, and the complete set of result artefacts, laid out in the same directory structure the notebooks expect. Download it, point your configured `saved/` and `data_v2/` paths at it, and no further assembly is required.

 
---
 
## Running the notebooks
 
These notebooks are the record of the experiments as they were run, on the hardware described above. Library versions have moved on since execution.
