# Shebang - Specifies the interpreter that should be used to execute the script
# Use bash interpreter
#!/bin/bash

# Color scheme variables for error message
RED='\033[0;41;30m'
STD='\033[0;0;39m'

# pause to display the output and wait for user input
pause(){
    read -p "Press [Enter] key to continue..."
}

rot13_encrypt(){
    # Read and aliase message and shifts from the passed-in arguments
    local message=$1
    local shifts=$2
    
    encrypted_message=$(echo "$message" | tr "[A-Za-z]" "[N-ZA-Mn-za-m]")
    
    echo $encrypted_message
}

rot13_decrypt(){
    # Read and aliase message and shifts from the passed-in arguments
    local message=$1
    local shifts=$2
    
    decrypted_message=$(echo "$message" | tr "[N-ZA-Mn-za-m]" "[A-Za-z]")
    
    echo $decrypted_message
}

# Caesar's cipher encrypt
caesar_encrypt(){
    # Read and aliase message and shifts from the passed-in arguments
    local message=$1
    local shifts=$2
    
    echo "Shifted $message by $shifts"
    
    encrypted_message=$(echo "$message" | tr "[A-Za-z]" "[D-ZA-Cd-za-c]")
    
    echo $encrypted_message
}

caecar_decrypt(){
    # Read and aliase message and shifts from the passed-in arguments
    local message=$1
    local shifts=$2
    
    decrypted_message=$(echo "$message" | tr "[D-ZA-Cd-za-c]" "[A-Za-z]")
    echo $decrypted_message
}

# Read a message from file
read_from_file() {
    read -p "Enter the name of a file to read: " filename
    # Display the message
    echo -n "Message: "
    cat $filename
    echo ""
    pause
}

# Read a message from input
read_from_input(){
    read -p "Enter the message read: " message
}

# Main menu
while true; do
    # clear
    echo "Encryption Utility"
    echo "1. Read message from a file"
    echo "2. Type a message"
    echo "3. Exit"
    read -p "Enter your choice: " choice
    
    case $choice in
        1) # Read from file
            read -p "Enter file name: " filename
            if [ ! -f "$filename" ];
            then
                echo "File not found!"
                pause
                continue
            fi
            # Read the file contents and store it in a variable
            message=$(<"$filename")
            # Display the message
            echo "Message: $message"
            pause
        ;;
        2) # Type a message
            read -p "Enter your message: " message
            # pause
        ;;
        3) # Exit
            echo "Exiting..."
            exit 0
        ;;
        *) # Invalid choice
            echo "Invalid choice!"
            pause
            
            continue
        ;;
    esac
    
    echo "Choose encryption method:"
    echo "1. ROT13"
    echo "2. Caesar's Cipher"
    read -p "Enter your choice: " enc_choice
    
    case $enc_choice in
        1) method="ROT13";;
        2)
            method="Caesar's Cipher"
            read -p "Enter number of shifts: " shifts
        ;;
        *) echo "Invalid choice!"
            pause
            continue
        ;;
    esac
    
    echo "Choose operation:"
    echo "1. Encrypt"
    echo "2. Decrypt"
    read -p "Enter your choice: " op_choice
    
    case $op_choice in
        1) op="Encrypt";;
        2) op="Decrypt";;
        *) echo "Invalid choice!"
            pause
            continue
        ;;
    esac
    
    read -p "Enter output file name: " output_file
    
    case $method in
        "ROT13")
            if [ $op_choice -eq 1 ];
            then
                encrypted_message=$(rot13_encrypt $message $shifts)
                echo "Encrypted message: $encrypted_message"
                echo "$encrypted_message" > "$output_file"
                pause
            else
                decrypted_message=$(rot13_decrypt $message $shifts)
                echo "Decrypted message: $decrypted_message"
                echo "$decrypted_message" > "$output_file"
                pause
            fi
        ;;
        "Caesar's Cipher")
            if [ $op_choice -eq 1 ];
            then
                encrypted_message=$(caesar_encrypt $message $shifts)
                echo "Encrypted message: $encrypted_message"
                pause
                echo "$encrypted_message" > "$output_file"
            else
                decrypted_message=$(caesar_decrypt $message $shifts)
                echo "Decrypted message: $decrypted_message"
                pause
                echo "$decrypted_message" > "$output_file"
            fi
        ;;
    esac
    
    pause
    
done