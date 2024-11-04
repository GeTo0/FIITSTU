import socket
import signal
import sys

def signal_handler(sig, frame):
    print("Shutting down server.")
    sys.exit(0)

def start_server(host='0.0.0.0', port=12345):
    # Create a TCP/IP socket
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(1)
    print(f"Server listening on {host}:{port}")

    # Register signal handler for graceful shutdown
    signal.signal(signal.SIGINT, signal_handler)

    # Open the file in append mode to ensure data is not overwritten
    with open('output.txt', 'a') as file:
        while True:
            # Wait for a connection
            connection, client_address = server_socket.accept()

            try:
                # Receive data in small chunks and write it to file
                while True:
                    data = connection.recv(1024)  # Receive up to 1024 bytes
                    if data:
                        decoded_data = data.decode('utf-8')  # Decode and print the data
                        print(decoded_data)
                        file.write(decoded_data + '\n')  # Write to file with a newline for each chunk
                        file.flush()  # Flush the file buffer to ensure immediate writing
                    else:
                        break
            finally:
                connection.close()

    server_socket.close()  # Ensure the socket is closed on exit

if __name__ == "__main__":
    ip_server = '192.168.1.223'
    start_server(host=ip_server, port=12345)