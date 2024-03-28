# define PY_SSIZE_T_CLEAN
import math
import os
import random
import struct
import threading
import time
import socket
import crcmod
import tkinter as tk

thread_status = True
switching_event = threading.Event()


def help():
    root = tk.Tk()

    # specify size of window.
    root.geometry("1250x500")

    # Create text widget and specify size.
    T = tk.Text(root, height=1000, width=1500)

    # Create label
    l = tk.Label(root, text="Information panel")
    l.config(font=("Courier", 14))

    Fact = """
 CONNECTING:
     Receiver must write a port, where the communication will be taking place
     Sender must write IP address of a server, where he wants to connect. You can use 'localhost'
     -----------------------------

 SWITCHING USERS / OPTIONS:
     After connecting to the server, Receiver must input '1' to continue (0 to exit program or 2 to switch users)
     Sender then must choose, what he wants to do.
     Sender can choose to switch users, which will send impulse to receiver, and he can either accept or no.
     Receiver will be able to switch users after receiving a message, where there will be 5 seconds pause to decide
     If he decides to switch users, both users are switched immediately.
     If you dont manage to choose in those 5 seconds, you can still switch by choosing 2, but sender must write random input in order for it to work.
     -----------------------------

 SENDING FILES:
     To send a file, the file must be in the current working directory
     Sender must only write the name of the file (f.e. warfacefotka.jpg)
     Receiver must write path to where to save the file (f.e. C:\\Users\\PC\\Desktop\\)"""

    # Create an Exit button.
    b2 = tk.Button(root, text="Exit",
                   command=root.destroy)

    l.pack()
    T.pack()
    b2.pack()

    # Insert The Fact.
    T.insert(tk.END, Fact)

    tk.mainloop()


def keep_alive(sender_sock, receiver_addr, interval):
    global switching_event
    while True:
        if not thread_status:
            return
        sender_sock.sendto(str.encode('7'), receiver_addr)
        try:
            data, _ = sender_sock.recvfrom(1500)
            what = str(data.decode())
        except (socket.timeout, socket.gaierror):
            print("Error receiving data. Connection may be lost.")
            return

        if what == '7':
            print("Connection is working")
        elif what == '4':
            switching_event.set()
            break
        else:
            print("Connection ended")
            break
        time.sleep(interval)


def start_thread(sender_sock, receiver_addr, interval):
    thread = threading.Thread(target=keep_alive, args=(sender_sock, receiver_addr, interval))
    thread.daemon = True
    thread.start()
    return thread


def switch_users(sender_socket, address):
    print("Sending impulse to other person for switching users")
    sender_socket.sendto(str.encode('3'), address)
    while True:
        temp = sender_socket.recv(1500)
        temp = str(temp.decode())
        response = temp[:3]
        if response == "yes":
            receiver(sender_socket, address)
        elif response == "no":
            print("Other user doesnt want to change users")
            return


def sender_login():
    while True:
        try:
            sender_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            address = input("IP address of server (can use 'localhost'):")
            port = input("Port:")
            server_address = (address, int(port))
            sender_socket.sendto(str.encode(""), server_address)  # send empty string to server to indicate connection
            sender_socket.settimeout(20)
            data, address = sender_socket.recvfrom(1500)
            data = data.decode()
            if data == "1":  # from header, receive from server, connection established
                print("Connected to address:", server_address)
                sender(sender_socket, server_address)
                print("Disconnecting...")
                return

        except (socket.timeout, socket.gaierror) as err:
            print(err)
            print("Connection lost. Try again")
            continue


def receiver_login():
    receiver_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    port = input("Input port: ")
    receiver_socket.bind(("", int(port)))
    data, address = receiver_socket.recvfrom(1500)
    receiver_socket.sendto(str.encode("1"), address)
    print("Established connection from address:", address)
    receiver(receiver_socket, address)


def sender(sender_socket, server_address):
    global thread_status
    global switching_event
    thread = None
    interval = 5

    while True:
        if switching_event.is_set():  # Check if switching event is set
            switching_event.clear()  # Reset the event
            print("\nSwitching to receiver role.")
            receiver(sender_socket, server_address)
            return

        print("0 to exit program")
        print("1 for text message")
        print("2 for file message")
        print("3 for switching roles")
        print("4 for keep alive")
        sender_choice = input()

        if switching_event.is_set():  # Check if switching event is set
            switching_event.clear()  # Reset the event
            print("\nSwitching to receiver role.")
            receiver(sender_socket, server_address)
            return

        if sender_choice == '0':
            if thread is not None:
                thread_status = False
                thread.join()
            return
        elif sender_choice == '1':
            if thread is not None:
                thread_status = False
                thread.join()
            send_messages(sender_socket, server_address, "t")
            thread_status = True
            thread = start_thread(sender_socket, server_address, interval)
            time.sleep(5)

        elif sender_choice == '2':
            if thread is not None:
                thread_status = False
                thread.join()
            send_messages(sender_socket, server_address, "f")
            thread_status = True
            thread = start_thread(sender_socket, server_address, interval)
            time.sleep(5)

        elif sender_choice == '3':
            if thread is not None:
                thread_status = False
                thread.join()
            switch_users(sender_socket, server_address)

        elif sender_choice == '4':
            thread_status = True
            thread = start_thread(sender_socket, server_address, interval)
            print("Keep alive - active")

        else:
            print("Wrong input")


def receiver(receiver_socket, address):
    global thread_status
    while True:
        print("0 for exit")
        print("1 to continue")
        print("2 to switch users")
        receiver_choice = input()
        if receiver_choice == '0':
            thread_status = False
            receiver_socket.close()
            return
        elif receiver_choice == '1' or receiver_choice == '2':
            print("Server is running")
        try:
            receiver_socket.settimeout(60)
            while True:
                while True:
                    data = receiver_socket.recv(1500)
                    what = str(data.decode())
                    if what == '7':  # check if received data is keep alive or message (7=keep alive)
                        print("Keep alive received")
                        if receiver_choice == '2':
                            receiver_socket.sendto(str.encode('4'), address)
                            time.sleep(2)
                            print("\nSwitching to sender role.")
                            sender(receiver_socket, address)
                            return
                        else:
                            receiver_socket.sendto(str.encode('7'), address)
                        what = ''
                        break
                    else:
                        break
                typ = what[:1]  # as defined in my header, first in data is type and after comes number of fragments
                number_of_packets = what[1:]
                if typ == '1':
                    print("Text message incoming, it will consist of " + number_of_packets + " packets")
                    receive_messages(number_of_packets, receiver_socket, "t")
                    break
                elif typ == "2":
                    print("File message incoming, it will consist of " + number_of_packets + " packets")
                    receive_messages(number_of_packets, receiver_socket, "f")
                    break
                elif typ == "3":
                    print("The other user wants to switch the roles, do you agree?")
                    while True:
                        temp = input('yes/no')
                        if temp == 'yes':
                            receiver_socket.sendto(str.encode('yes'), address)
                            sender(receiver_socket, address)
                            break
                        elif temp == 'no':
                            receiver_socket.sendto(str.encode('no'), address)
                            break
        except socket.timeout:
            print("Inactivity detected, shutting down")
            receiver_socket.close()
            return


def send_messages(sender_socket, address, msg_type):
    message = None
    send_message = None
    filename = None
    filenameBasic = None
    if msg_type == "t":
        message = input("Enter message: ")
    elif msg_type == "f":
        filenameBasic = input("Enter the file name: ")
        filename = os.path.abspath(filenameBasic)
    fragment_size = int(input("Enter fragment size: "))

    while fragment_size > 60000 or fragment_size <= 0:
        print("Invalid fragment size, must be between 1 and 60000")
        fragment_size = int(input("Enter fragment size: "))

    if msg_type == "t":
        number_of_packets = math.ceil(len(message) / fragment_size)
        print("You will send " + str(number_of_packets) + " packets.")
        initializing_packet = ("1" + str(number_of_packets))
        initializing_packet = initializing_packet.encode('utf-8').strip()
        sender_socket.sendto(initializing_packet, address)

    elif msg_type == "f":
        size = os.path.getsize(filename)
        print("File name:", filename, "Size: ", size, "B")
        print("Absolute path is: ", os.path.abspath(filename))
        file = open(filename, "rb")
        number_of_packets = math.ceil(size / fragment_size)
        print("You will send " + str(number_of_packets) + " packets.")

        message = file.read()
        initializing_packet = ("2" + str(number_of_packets))
        initializing_packet = initializing_packet.encode('utf-8').strip()
        sender_socket.sendto(initializing_packet, address)

    packet_count = 0
    errors = 0

    error_addition = input('Do you want errors in your message? (1) Yes | (2) No ')
    while error_addition != "1" and error_addition != "2":
        error_addition = input('Do you want errors in your message? (1) Yes | (2) No ')
    if error_addition == "1":
        errors = int(input('Number of errors: '))

    sender_socket.settimeout(20)
    counter = 4
    while True:
        if len(message) == 0:
            if msg_type == "f":
                temp = filenameBasic.encode('utf-8')
                sender_socket.sendto(temp, address)
                print("sending file name...")
            break
        while True:
            if len(message) == 0:
                if msg_type == "f":
                    temp = filenameBasic.encode('utf-8')
                    sender_socket.sendto(temp, address)
                    print("sending file name...")
                break
            tempM = None
            if msg_type == "t":
                send_message = message[:fragment_size]
                tempM = str.encode(send_message)
            elif msg_type == "f":
                send_message = message[:fragment_size]
                tempM = send_message

            header = struct.pack("c", str.encode("6")) + struct.pack("HH", len(send_message),
                                                                     packet_count)  # 6= Prenos dát
            crc_func = crcmod.predefined.mkCrcFun('xmodem')
            crc = crc_func(header + tempM)

            if error_addition == "1" and errors > 0:
                if random.random() < 0.5:
                    if msg_type == "f":
                        crc += 1
                        errors -= 1
                    elif msg_type == "t":
                        temp_list = list(send_message)
                        index_to_change = random.randint(0, len(temp_list) - 1)
                        temp_list[index_to_change] = str(random.randint(0, 9))
                        temp2 = ''.join(temp_list)
                        errors -= 1
                        send_message = temp2

            if msg_type == "t": send_message = str.encode(send_message)

            header = struct.pack("c", str.encode('6')) + struct.pack("HHH", fragment_size, packet_count, crc)
            sender_socket.sendto(header + send_message, address)

            print(packet_count, str(send_message))
            try:
                data, address = sender_socket.recvfrom(1500)
                data = data.decode()
                if data == "9":  # 9 = data dorucene spravne
                    if counter == 0:
                        packet_count += 1
                        message = message[fragment_size:]
                        counter = 4
                    else:
                        counter -= 1
                elif data == "12":
                    counter -= 1
                break
            except(socket.timeout, socket.gaierror) as e:
                print("Something went wrong, Retransmitting packet...")
                continue


def receive_messages(number_of_packets, receiver_socket, msg_type):
    packet_count = 0
    received_packet_count = 0
    complete_message = []
    sequence_numbers = set()
    counter = 5

    while True:
        if packet_count == int(number_of_packets):
            break
        while True:
            if packet_count == int(number_of_packets):
                break

            data, address = receiver_socket.recvfrom(64000)
            if len(data) < 7:
                continue
            message = data[7:]
            length, packet_number, crc_got = struct.unpack("HHH", data[1:7])

            header = struct.pack("c", str.encode("6")) + struct.pack("HH", len(message), packet_number)

            crc_func = crcmod.predefined.mkCrcFun('xmodem')
            crc = crc_func(header + message)

            if crc == crc_got:
                if packet_number not in sequence_numbers:
                    sequence_numbers.add(packet_number)

                    if msg_type == "t":
                        complete_message.append(message.decode())
                        print(
                            f"Packet number {packet_count} was successful. Message: {message.decode()}, it´s size is {len(message)}, fragment size is {length}, crc: {crc_got}")
                    elif msg_type == "f":
                        complete_message.append(message)
                        print(
                            f"Packet number {packet_count} was successful, it´s size is {len(message)}, fragment size is {length}, crc: {crc_got}")
                    if counter == 0:
                        packet_count += 1
                    received_packet_count += 1
                    receiver_socket.sendto(str.encode("9"), address)
                    counter -= 1
                else:
                    receiver_socket.sendto(str.encode("9"), address)
                    print(
                        f"Packet number {packet_count} was duplicate. Message: {message.decode()}")

                    counter -= 1
                    if counter == 0:
                        packet_count += 1
                        counter = 5

            else:
                if msg_type == "t":
                    print(
                        f"Packet number {packet_count} was unsuccessful. Message: {message.decode()}, it´s size is {len(message)}, fragment size is {length}, crc: {crc_got}")
                else:
                    print(
                        f"Packet number {packet_count} was unsuccessful, it´s size is {len(message)}, fragment size is {length}, crc: {crc_got}")

                receiver_socket.sendto(str.encode("12"), address)
                received_packet_count += 1

    print("Number of damaged packets: ", received_packet_count - packet_count)
    print("Number of all received packets: ", received_packet_count)
    print("Number of accepted packets: " + str(packet_count))

    if msg_type == "t":
        print("Message:", ''.join(complete_message))
    elif msg_type == "f":
        temp, _ = receiver_socket.recvfrom(1500)
        filename = str(temp.decode())
        destination_dir = input("Enter the destination directory path: ")
        file_path = os.path.join(destination_dir, filename)

        file = open(file_path, "wb")

        for fragment in complete_message:
            file.write(fragment)
        file.close()

        size = os.path.getsize(file_path)
        print("Name: ", filename, "Size: ", size, "B")
        print("Absolute path:", os.path.abspath(file_path))


if __name__ == "__main__":
    while True:
        print("1 for sender")
        print("2 for receiver")
        print("3 to exit")
        print("4 for help panel")
        choice = input()
        if choice == '1':
            sender_login()
            break
        elif choice == '2':
            receiver_login()
            break
        elif choice == '3':
            break
        elif choice == '4':
            help()
        else:
            print("Try to input something different")
