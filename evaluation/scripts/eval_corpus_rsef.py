import pandas as pd
import json
import re
import os

ARXIV_REGEX = r'.*(\d{4}\.\d{4,5}).*'

def str_to_arxivID(string):
    try:
        match = re.search(ARXIV_REGEX, string)
        if match:
            return match.group(1)
        return None
    except:
        return None

def calculate_metrics(json_path, xlsx_path, output_path):
    # Read Corpus TSV
    xlsx_data = df = pd.read_excel(xlsx_path, "public", dtype=str)

    with open(json_path, 'r') as f:
        json_data = json.load(f)

    # Initialize counters
    TruePositive = 0
    TrueNegative = 0
    FalseNegative = 0
    FalsePositive = 0
    fails = {"FalseNeg": [], "FalsePos": []}

    for index, row in xlsx_data.iterrows():
        corp_arxiv = str_to_arxivID(row['paper_arxiv_id'])
        if corp_arxiv is None:
            continue
        
        prediction = row['BiDirectional'] == 'True'  # Assuming the value in sheet is 'True' or 'False'
        print(True)
        # Check against JSON data
        rsef_arxivs = json_data.keys()
        if corp_arxiv in rsef_arxivs: # RSEF considers it bidirectional
            if prediction:
                TruePositive += 1
            else:
                FalsePositive += 1
                fails["FalsePos"].append(corp_arxiv)
        else: # RSEF does not consider it bidirectional
            if prediction:
                FalseNegative += 1
                fails["FalseNeg"].append(corp_arxiv)
            else:
                TrueNegative += 1

    # Calculate precision, recall, and f1 score
    precision = TruePositive / (TruePositive + FalsePositive) if (TruePositive + FalsePositive) > 0 else 0
    recall = TruePositive / (TruePositive + FalseNegative) if (TruePositive + FalseNegative) > 0 else 0
    f1_score = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0

    # Prepare result
    result = {
        "_failed Rlsepos": fails,
        "f1_score": f1_score,
        "precision": precision,
        "recall": recall
    }

    # Write result to JSON file
    with open(output_path, 'w') as f:
        json.dump(result, f, indent=4)

    return result

# Example usage
current_script_path = os.path.dirname(os.path.abspath(__file__))
xlsx_file = "corpus_arxiv_bidirectional_12_23.xlsx"
xlsx_path = os.path.join(current_script_path, "..", "..", "corpus", xlsx_file)


json_file_name = "bidir.json"
json_file_path = os.path.join(current_script_path, "..", "output", json_file_name)
print(json_file_path)

output_json_path = 'output_metrics_RSEF.json'
calculate_metrics(json_file_path, xlsx_path, output_json_path)
