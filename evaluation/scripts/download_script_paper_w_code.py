import os
import json
import pandas as pd
import requests
from time import sleep
import logging


def request_and_write_to_file(url:str, file_path):
    try:
        response = requests.get(url)
        if response.status_code != 200:
            logging.error(f"Issue creating the request: {response.status_code}")
            return False
        sleep(3)    # This is due to arxiv api limitations
        with open(file_path, "wb") as downloaded_file:
            downloaded_file.write(response.content)
        return True
            
    except Exception as e:
        logging.error(f"Issue while downloading the file url: {url} Exception: {e}")
        return False


def download_corpus_files(path_corpus, output_path):

    downloaded_json_data = {}   # Where we will store all metadata, RSEF would be processed_metadata.json
    # Counters
    pdf_success_count, pdf_fail_count = 0, 0
    latex_success_count, latex_fail_count = 0, 0
    
    try:
        #df = pd.read_csv(path_corpus, delimiter="\t",dtype=str)
        df = pd.read_excel(path_corpus, "public")
    except Exception as e:
        logging.error(f"Issue while trying open the corpus file {e}")
        return pdf_success_count, pdf_fail_count, latex_success_count, latex_fail_count
    
    try:
        os.makedirs(output_path, exist_ok=True)
    except:
        logging.error("Issue while trying to create the output directory")
        return pdf_success_count, pdf_fail_count, latex_success_count, latex_fail_count
    
    for index, row in df.iterrows():
        doi = str(row["DOI"]).replace("'","")  # Convert DOI to a string
        paper_title = row["paper_title"]
        pdf_url = row["paper_url_pdf"]
        arxiv_id = str(row["paper_arxiv_id"]).replace("'","")
                     
        if pd.isna(arxiv_id):
            logging.error("Arxiv_id is not valid")
            continue
        
        arxiv_directory = os.path.join(output_path, arxiv_id)
        try:
            os.makedirs(arxiv_directory)
        except Exception as e:
            print(f"Failed to create directory for {arxiv_id}: {e}")
            print("================")
            continue

        print(f"Downloading files for {arxiv_id}")
        # Download the PDF file
        pdf_filename = f"{arxiv_id}.pdf"
        pdf_filepath = os.path.join(arxiv_directory, pdf_filename)
        if request_and_write_to_file(pdf_url, pdf_filepath):
            print("Downloaded PDF")
            pdf_success_count += 1
        else:
            print(f"Failed to download PDF for {arxiv_id}")
            pdf_fail_count += 1

        # Download Latex file
        latex_url = f"https://arxiv.org/e-print/{arxiv_id}"
        latex_filename = f"{arxiv_id}.tar.gz"
        latex_filepath = os.path.join(arxiv_directory, latex_filename)
        
        
        if request_and_write_to_file(latex_url, latex_filepath):
            print("Downloaded latex")
            latex_success_count += 1
        else:
            print(f"Failed to download LaTeX for {arxiv_id}")
            latex_fail_count += 1
        
        # Add the entry to the JSON data
        downloaded_json_data[arxiv_id] = {
            "arxiv": arxiv_id,
            "doi": doi,
            "file_name": pdf_filename,
            "file_path": pdf_filepath,
            "title": paper_title,
        }
        print("================")
        json_path = os.path.join(output_directory,"corpus_metadata.json")
        with open(json_path, "w+") as f:
            json.dump(downloaded_json_data, f, indent=4)
    
    print(f"PDF:{pdf_success_count}")
    print(f"Failed_pdfs: {pdf_fail_count}")
    print(f"Source zips: {latex_success_count}")
    print(f"Failed source zips: {latex_fail_count}")
    
    return pdf_success_count, pdf_fail_count, latex_success_count, latex_fail_count


# Create a directory to store files if it doesn't exist
output_directory = "./sources"
#csv_file = "./corpus/corpus.tsv"  # Replace with your CSV filename
current_script_path = os.path.dirname(os.path.abspath(__file__))
xlsx_file = "corpus_arxiv_bidirectional_12_23.xlsx"
xlsx_path = os.path.join(current_script_path, "..", "..", "corpus", xlsx_file)
# Manaully download
download_corpus_files(path_corpus=xlsx_path, output_path=output_directory)



