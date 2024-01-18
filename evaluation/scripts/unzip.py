import os
import glob
import tarfile



def unzip_latex_tars(base_dir):
    fails = []
    tar_files = glob.glob(os.path.join(base_dir, '**/*.tar.gz'), recursive=True)

    for tar_file in tar_files:
        # Extract the .tar.gz file
        try:
            with tarfile.open(tar_file, 'r:gz') as tar:
                # Extract all the contents into the directory of the tar.gz file
                tar.extractall(path=os.path.dirname(tar_file))
            print(f'Extracted: {tar_file}')
        except Exception as e:
            print(f'Error extracting {tar_file}: {e}')
            fails.append((tar_file, f"reason: {e}"))
            
    print("+++++++++++++")
    print("Failed:")
    print(fails)
    fails_txt_path = os.path.join(base_dir,"failed_to_unzip.txt")
    with open(fails_txt_path, "w+") as f:
        for fail in fails:
            f.write("Path: " + fail[0] + "\n")
            f.write("Reason: " + fail[1] + "\n")
            f.write("\n")


base_dir = "./sources" # if executed by evaluate.sh you may need to change this for it to work
unzip_latex_tars(base_dir)
