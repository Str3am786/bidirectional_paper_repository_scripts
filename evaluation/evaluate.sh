#!/bin/bash
while true; do
    echo "Please select an option:"
    echo "1: Evaluate RSEF"
    echo "2: Evaluate Latex pipeline (Hackathon)"
    echo "3: Exit"

    read -p "Please input your first option: " first_option

    case $first_option in
        1)
            echo
            echo "Option for RSEF selected. Please choose a sub-option:"
            echo "1: Redownload all files"
            echo "2: Use existing files"
            read -p "Please input your second option: " second_option
            case $second_option in
                1)
                    echo "You have chosen to evaluate the RSEF pipeline by choosing to redownload all the files."
                    python ./scripts/download_script_paper_w_code.py
                    rsef process -i ./sources/corpus_metadata.json
                    rsef assess -i ./processed_metadata.json -B

                    break
                    ;;
                2)
                    echo "You have chosen to evaluate the RSEF pipeline using existing files."
                    rsef process -i ./corpus_files/corpus_metadata.json
                    rsef assess -i ./processed_metadata.json -o bidirectional -B
                    break
                    ;;
                *)
                    echo 
                    echo "#################################"
                    echo "Invalid option. Please try again."
                    echo "#################################"
                    echo
                    ;;
            esac
            ;;
        2)
            echo "Latex pipeline (Hackathon) selected. Please choose a sub-option:"
            echo "1: Redownload all files"
            echo "2: Use existing files"
            read -p "Please input your second option: " second_option
            case $second_option in
                1)  
                    echo "Option to redownload all files for Latex pipeline selected."
                    python ./scripts/download_script_paper_w_code.py
                    python unzip
                    echo 
                    echo "Move the sources folder into the python hackathon package"
                    echo "Run this command: python main.py merge-latex"
                    echo "Set the variable with your github token"
                    echo "python main.py run --type latex"
                    # Add more commands as needed
                    ;;
                2)  
                    echo
                    echo "Option to use existing files for Latex pipeline selected."
                    echo
                    echo "Move the sources folder into the python hackathon package"
                    echo
                    echo "Set the variable with your github token"
                    echo "python main.py run --type latex"
                    echo 
                    # Add commands to process existing files
                    ;;
                *)  
                    echo 
                    echo "#################################"
                    echo "Invalid option. Please try again."
                    echo "#################################"
                    echo
                    ;;
            esac
            ;;
        3)
            echo "Exiting."
            break
            ;;
        *)
            echo "Invalid first option. Please try again."
            ;;
    esac
done
