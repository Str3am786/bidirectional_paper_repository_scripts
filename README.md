
# bidirectional_paper_repository_scripts

This repository contains the scripts and data used to write a paper sent to the MSR 2024 conference.


## Folder Structure

### Scripts

In the folder scripts, we can find the scripts used to extract the results.

* add_year_to_bidir: Add a year to the bidirectional links.

* count_bidir_n_urls: Return the number of bidirectional urls.

* count_valid_merge_tex: Return the number of merge tex. This file is built in the latex pipeline.

* generate_dataset: This script integrate the results of the PDF pipeline (bidir.json -> evaluation folder) and the Latex pipeline (results_sources_XXX -> evaluation folder). Also, it provides some statistics about the overlap between both pipelines. The result is the dataset described in our paper.

* statistics_bidir: This script returns the distribution of links in the papers. It means, how many papers have 1, 2, 3 links.

* statistics_raw_bidir: This script returns the distribution of links in all anaThis script download the papers of the category Software Engineering in arxiv.

  

### corpus

  

In this folder, you can find the corpus used to evaluate the performance of both pipelines. The xlsx is divided into 3 sheets: Legend, Debugger and Public. 

  

### dataset

  

In this folder, you can find the dataset generated with the bidirectional correspondences between software and paper. It means, a software repository is cited in a paper, and a papers is cited in a software repository.

  

### evaluation

  

This folder contains a script to download and evaluate each of the pipelines as well as the old metrics (precision, recall, f1-score) calculated for both pipelines (output_metrics_XXXX.json).

To evaluate the pipelines you will need to run ``evaluate.sh``.

**- Evaluating RSEF :**  



- First, confirm that RSEF is installed and operational. 
1. Navigate to the `./evaluation` directory.
2. Execute the script by running `./evaluate.sh`. If the script fails to run, modify its file permissions using the command `chmod +x evaluate.sh`.
3. Pick the right options for you
``` 
Please select an option:
1: Evaluate RSEF
2: Evaluate Latex pipeline (Hackathon)
3: Exit

Please input your first option:
```
Select a number and press enter, in this case it would be 1
```
Option for RSEF selected. Please choose a sub-option:

1: Redownload all files
2: Use existing files

Please input your second option:
```
Here you can choose to use already downloaded Repositories and PDF's or you can choose to redownload all for the most up to date evaluation. **Warning** This may result in mismatch with previously established corpus

**- Evaluating hackathon pipeline :**  

1. You will need to move the `./sources` folder into the Directory of the hackathon python package.

2. You will need to set the environment variable: ``GITHUB_TOKEN``.   
Run this command: ``export GITHUB_TOKEN="XXXXXX"``
You can generate a new token here:  [https://github.com/settings/tokens](https://github.com/settings/tokens) and set the env var.

3. Then run ``python main.py merge-latex`` 
4. Then run ``python main.py run --type latex``
5. Once the results_sources_XXXXXX.csv has been created move it to the evaluate folder and run ``python eval



**- Within Evaluation you can find previous results of the pipelines.**

* bidir.json: It is the file with the results of the PDF pipeline.

* bidir_with_years.json: These are the results of the PDF pipeline distributed by year.

* processed_metadata.json: It contains the results of the analysis of the papers downloaded, including bidir and non bidir papers.

* result_sources_XXXXX.csv: It contains the results of the latex pipeline.

  

# Requirements

  

* Python 3.9

  

# How to use

  

First, you have to install the python libraries.

  

 `pip install -r requirements.txt`
  

Then you can execute each script. Please, note that the folders and name of the files (found in evaluation) can be different, so you will have to change the code to add the correct pathname.