import pandas as pd
import json
import re
import os 

ARXIV_REGEX = r'.*(\d{4}\.\d{4,5}).*'

def str_to_arxivID(string):
    try:
        match = re.search(ARXIV_REGEX, string)
        if match:
            arxiv = match.group(1)
            return arxiv
        return None
    except:
        return None

def find_directionality_corpus(arxiv_id, pandas_xlsx):
    for _, csv_row in pandas_xlsx.iterrows():
        corp_arxiv = csv_row['paper_arxiv_id']
        if type(corp_arxiv) == float:
            continue
        if corp_arxiv == arxiv_id:
            return csv_row['BiDirectional'] == "True"
    return None


def calculate_metrics(csv_path, xlsx_path, output_path):
    # Read Results and Corpus
    results_data = pd.read_csv(csv_path, dtype=str)
    corpus_data = pd.read_excel(xlsx_path, "public", dtype=str)

    # Initialize counters
    TruePositive = 0
    TrueNegative = 0
    FalseNegative = 0
    FalsePositive = 0

    # Initialize dictionary to store failed repositories
    fails = {"FalseNeg": [], "FalsePos": []}

    # Iterate over each row in the CSV
    for _, csv_row in results_data.iterrows():
        arxiv_id = csv_row['ArXiV id']
        result = csv_row['Result']

        # Find value within the corpus
        bi_directional = find_directionality_corpus(arxiv_id=arxiv_id, pandas_xlsx=corpus_data)
        if bi_directional is None:
            print(arxiv_id)

        result_bool = result == "Found"

        # Calculate metrics
        if result_bool and bi_directional:
            TruePositive += 1
        elif result_bool and not bi_directional:
            FalsePositive += 1
            fails["FalsePos"].append(arxiv_id)
        elif not result_bool and not bi_directional:
            TrueNegative += 1
        elif not result_bool and bi_directional:
            FalseNegative += 1
            fails["FalseNeg"].append(arxiv_id)


    # Calculate precision, recall, and f1 score
    precision = TruePositive / (TruePositive + FalsePositive) if (TruePositive + FalsePositive) > 0 else 0
    recall = TruePositive / (TruePositive + FalseNegative) if (TruePositive + FalseNegative) > 0 else 0
    f1_score = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0

    # Prepare result
    result = {
        "_failed Repos": fails,
        "f1_score": f1_score,
        "precision": precision,
        "recall": recall
    }

    # Write result to JSON file
    with open(output_path, 'w') as f:
        json.dump(result, f, indent=4)

    return result

# Modify these values to necessary inputs
current_script_path = os.path.dirname(os.path.abspath(__file__))
# Modify to where the corpus may be 
xlsx_file = "corpus_arxiv_bidirectional_12_23.xlsx"
xlsx_path = os.path.join(current_script_path, "..", "..", "corpus", xlsx_file)
# Modify to where the results from the hackathon is located
results_file_path = "results_sources_hackathon.csv" #'./results.csv
#res_path = os.path.join(current_script_path, "..", "previous_evaluations", results_file_path)
res_path = os.path.join(current_script_path, "..", results_file_path)
output_json_path = './output_metrics_hacka.json'

calculate_metrics(csv_path=res_path, xlsx_path=xlsx_path, output_path=output_json_path)


