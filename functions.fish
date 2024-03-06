# Function: csv_to_txt
function csv_to_txt --description "Renames all CSV files in the current directory to TXT files"
    set files *.csv
    if test (count $files) -eq 0
        echo "No CSV files found in the current directory."
        return 1
    end

    for file in $files
        set base_filename (basename -- "$file" .csv)
        mv -- "$file" "$base_filename.txt"
    end

    echo "Successfully renamed CSV files to TXT."
end



# Function: txt_to_csv
function txt_to_csv --description "Renames all TXT files in the current directory to CSV files"
    set files *.txt
    if test (count $files) -eq 0
        echo "No TXT files found in the current directory."
        return 1
    end

    for file in $files
        set base_filename (basename -- "$file" .txt)
        mv -- "$file" "$base_filename.csv"
    end

    echo "Successfully renamed TXT files to CSV."
end


# Function: add_extension
# Parameters: 1. Extension to be added. 2. (Optional) Directory to apply the extension (default is current directory).
function add_extension --description "Appends a specified extension to the filenames of files in the specified or current directory"
    # Check if the extension argument is provided.
    if test -z $argv[1]
        echo "Usage: add_extension <extension> [directory]"
        return 1
    end

    # Extract the extension from the first argument.
    set ext $argv[1]

    # Determine the directory to operate on (current directory if not specified).
    set directory (count $argv) -gt 1; and echo $argv[2]; or echo "."

    # Validate if the extension follows a valid format (alphanumeric characters only).
    if not string match -q '^[a-zA-Z0-9]+$' $ext
        echo "Error: Invalid extension format. Use alphanumeric characters only."
        return 1
    end

    # Iterate through files in the specified or current directory.
    for file in $directory/*
        # Check if the item is a regular file.
        if test -f $file
            # Extract the filename from the path.
            set filename (basename -- $file)

            # Extract the existing extension (if any) from the filename.
            set extension (string match -r '\.\w+$' $filename)

            # Skip files that already have an extension.
            if test -n $extension
                continue
            end

            # Rename the file by appending the specified extension.
            mv $file $filename.$ext
        end
    end
end


# Function: tmp
# Parameters: List of files to move.
function tmp --description "Move specified files to a temporary folder (default: ~/Temp)"
    # Check if files are provided as arguments.
    if test (count $argv) -eq 0
        echo "Usage: tmp <file1> <file2> ..."
        return 1
    end

    # Set the temporary folder path.
    set temp_folder ~/Temp

    # Create the temporary folder if it doesn't exist.
    if not test -d $temp_folder
        mkdir -p $temp_folder
        if test $status -ne 0
            echo "Error: Unable to create temporary folder $temp_folder."
            return 1
        end
    end

    # Iterate through provided files and move them to the temporary folder.
    for file_to_move in $argv
        # Check if the file exists before moving.
        if test -e $file_to_move
            mv -- $file_to_move $temp_folder
            if test $status -eq 0
                echo "Moved $file_to_move to $temp_folder"
            else
                echo "Error: Failed to move $file_to_move to $temp_folder."
            end
        else
            echo "Error: File $file_to_move not found."
        end
    end
end


# Function: split_parts
# Parameters: 1. Number of parts. 2. File to split.
function split_parts --description "Splits a specified file into the specified number of parts using the 'split' command"
    # Check if both number of parts and file are provided.
    if test (count $argv) -lt 2
        echo "Usage: split_parts <number_of_parts> <file>"
        return 1
    end

    # Extract the number of parts from the first argument.
    set parts $argv[1]

    # Validate that the number of parts is a positive integer.
    if not test $parts -gt 0 2>/dev/null
        echo "Error: Number of parts must be a positive integer."
        return 1
    end

    # Iterate through the specified files.
    for file in $argv[2..-1]
        # Check if the file exists before splitting.
        if not test -e $file
            echo "Error: File '$file' not found."
            return 1
        end
        
        # Extract the prefix from the file name (excluding the extension).
        set prefix (basename -- $file '.csv')

        # Use the 'split' command to split the file into the specified number of parts.
        split -n l/$parts --additional-suffix=.csv $file $prefix-

        # Provide feedback about the successful split.
        echo "File '$file' successfully split into $parts parts."
    end
end


# Function: split_lines
# Parameters: 1. Number of lines per file. 2. File to split.
function split_lines --description "Splits a specified file into parts based on the specified number of lines using the 'split' command"
    # Check if both number of lines and file are provided.
    if test (count $argv) -lt 2
        echo "Usage: split_lines <lines_per_file> <file>"
        return 1
    end

    # Extract the number of lines from the first argument.
    set lines $argv[1]

    # Validate that the number of lines is a positive integer.
    if not test $lines -gt 0 2>/dev/null
        echo "Error: Number of lines must be a positive integer."
        return 1
    end

    # Iterate through the specified files.
    for file in $argv[2..-1]
        # Check if the file exists before splitting.
        if not test -e $file
            echo "Error: File '$file' not found."
            return 1
        end

        # Extract the prefix from the file name (excluding the extension).
        set prefix (basename -- $file '.csv')

        # Use the 'split' command to split the file based on the specified number of lines.
        split -l $lines --additional-suffix=.csv $file $prefix-

        # Provide feedback about the successful split.
        echo "File '$file' successfully split into $lines lines per file."
    end
end

