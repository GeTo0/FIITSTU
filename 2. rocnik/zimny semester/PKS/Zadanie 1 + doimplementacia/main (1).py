from ruamel.yaml.scalarstring import PreservedScalarString
from scapy.all import rdpcap
import ruamel.yaml, ipaddress
from collections import defaultdict
import myDictionaries


def packetLength(hex_data, smalldict):
    #function that calculates length of packet
    length = len(hex_data)
    length = length // 2
    medialength = length + 4
    smalldict['len_frame_pcap'] = length
    if (medialength > 63):
        smalldict['len_frame_medium'] = medialength
    else:
        smalldict['len_frame_medium'] = 64

def frameType(hex_data, smalldict):
    #function that gets the type of frame
    type = hex_data[24:28]
    if (int(type, 16) >= 1500):
        smalldict['frame_type'] = "Ethernet II"
    else:
        data4 = hex_data[28:30]
        if (data4 == "aa"):
            smalldict['frame_type'] = "IEEE 802.3 LLC & SNAP"
        elif (data4 == "ff"):
            smalldict['frame_type'] = "IEEE 802.3 RAW"
        else:
            smalldict['frame_type'] = "IEEE 802.3 LLC"

def macAdr(packet, smalldict):
    #function that gets destination and source mac addresses
    mac_address = ":".join([packet[i:i + 2] for i in range(0, 12, 2)])
    smalldict['dst_mac'] = mac_address

    mac_address = ":".join([packet[i:i + 2] for i in range(12, 24, 2)])
    smalldict['src_mac'] = mac_address

def sapPid(hex_data, smalldict):
    #function that gets sap and pid
    if (smalldict['frame_type'] == "IEEE 802.3 LLC & SNAP"):
        pidHexa = hex_data[40:44]
        if myDictionaries.PIDs.get(int(pidHexa, 16)) == None:
            pidHexa = hex_data[92:96]
        smalldict['pid'] = myDictionaries.PIDs.get(int(pidHexa, 16))
    elif (smalldict['frame_type'] == "IEEE 802.3 LLC"):
        sapHexa = hex_data[30:32]
        smalldict['sap'] = myDictionaries.SAPs.get(int(sapHexa, 16))


def hexaDump(hex_data, smalldict):
    #function that puts hex data to its form (16 bytes in one row, each byte divided by space)
    hexDataFinal = ""
    counter2 = 1
    for pismeno in hex_data:
        hexDataFinal += pismeno
        if counter2 % 2 == 0 and counter2 % 32 != 0:
            hexDataFinal += ' '
        elif counter2 % 32 == 0:
            hexDataFinal += '\n'
        counter2 += 1
    return hexDump(hexDataFinal.upper(), smalldict)

def hexDump(hex_data, smalldict):
    #function that puts hexaDump to dictionary
    hexDump = PreservedScalarString(hex_data)
    smalldict['hexa_frame'] = hexDump

def ethType(hex_data, smalldict):
    #function that gets ether type
    if 'frame_type' in smalldict and smalldict['frame_type'] == "Ethernet II":
        temp = hex_data[24:28]
        smalldict['ether_type'] = myDictionaries.EtherTypes.get(temp)

def tcpUDP(hex_data, smalldict):
    #function that returns TCP or UDP for IPV4s
    if 'ether_type' in smalldict and smalldict['ether_type'] == "IPV4":
        temp = hex_data[46:48]
        smalldict['protocol'] = myDictionaries.Protocols.get(temp)
    # elif 'ether_type' in smalldict and smalldict['ether_type'] == "IPV6":
    #  temp=hex_data[40:42]
    # smalldict['protocol']=myDictionaries.Protocols.get(temp)

def srcdstPort(hex_data, smalldict):
    #function that gives source and destination port for TCP and UDP
    if 'protocol' in smalldict and (smalldict['protocol'] == "TCP" or smalldict['protocol']=="UDP"):
        smalldict['src_port'] = int(hex_data[68:72], 16)
        smalldict['dst_port'] = int(hex_data[72:76], 16)
        appProtocol(smalldict)

def appProtocol(smalldict):
    #function that gives packet protocol for TCP and UDP
    if 'protocol' in smalldict and smalldict['protocol'] == "TCP":
        temp = smalldict['src_port']
        if temp in myDictionaries.APPprotocols:
            smalldict['app_protocol'] = myDictionaries.APPprotocols.get(temp)
        else:
            temp = smalldict['dst_port']
            if temp in myDictionaries.APPprotocols:
                smalldict['app_protocol'] = myDictionaries.APPprotocols.get(temp)

    elif 'protocol' in smalldict and smalldict['protocol'] == "UDP":
        temp = smalldict['src_port']
        if temp in myDictionaries.APPprotocols:
            smalldict['app_protocol'] = myDictionaries.APPprotocols.get(temp)
        else:
            temp = smalldict['dst_port']
            if temp in myDictionaries.APPprotocols:
                smalldict['app_protocol'] = myDictionaries.APPprotocols.get(temp)

def srcdstIP(packet, smalldict):
    #function that gives packet source and destination IP address
    if 'ether_type' in smalldict and smalldict['ether_type'] == "IPV4":
        sourceIP = ".".join([str(int(packet[i:i + 2], 16)) for i in range(52, 60, 2)])
        destIP = ".".join([str(int(packet[i:i + 2], 16)) for i in range(60, 68, 2)])
        smalldict['src_ip'] = sourceIP
        smalldict['dst_ip'] = destIP

    elif 'ether_type' in smalldict and smalldict['ether_type'] == "IPV6":
        sourceIP = ':'.join(packet[i:i + 4] for i in range(44, 76, 4))
        destIP = ':'.join(packet[i:i + 4] for i in range(76, 108, 4))
        source_ip_obj = ipaddress.IPv6Address(sourceIP)
        dest_ip_obj = ipaddress.IPv6Address(destIP)
        sourceIP = source_ip_obj.compressed
        destIP = dest_ip_obj.compressed
        smalldict['src_ip'] = sourceIP
        smalldict['dst_ip'] = destIP

    elif 'ether_type' in smalldict and smalldict['ether_type'] == "ARP":
        sourceIP = ".".join([str(int(hex_data[i:i + 2], 16)) for i in range(56, 64, 2)])
        destIP = ".".join([str(int(hex_data[i:i + 2], 16)) for i in range(76, 84, 2)])
        smalldict['src_ip'] = sourceIP
        smalldict['dst_ip'] = destIP

def ipv4count(bigdict):
    #function that calculates unique IP addresses that sent packets and which one sent the most
    ipv4_packet_counts = defaultdict(int)
    max_count = 0
    max_senders = []

    for packet in bigdict['packets']:
        if 'src_ip' in packet and ':' not in packet['src_ip']:
            ipv4_packet_counts[packet['src_ip']] += 1

    for ip, count in ipv4_packet_counts.items():
        temp = {}
        temp['node'] = ip
        temp['number_of_sent_packets'] = count
        bigdict['ipv4_senders'].append(temp)

        if count > max_count:
            max_senders = [ip]
            max_count = count
        elif count == max_count:
            max_senders.append(ip)

    bigdict['max_send_packets_by'] = max_senders

def getHexData(packet):
    #function that returns hexdata as from wireshark from formated hex data in dictionary
    hexa_frame = packet.get('hexa_frame', '')
    hex_data = hexa_frame.replace(" ", "")
    hex_data = hex_data.replace("\n", "")
    return hex_data

def arpOrder(bigdict):
    #function that makes new dictionary for ARP and finds all needed information for them, extracts basic info from packets from bigdictionary
    arp_requests = []  # ARP requests
    arp_replies = {}  # ARP replies with IP as keys
    for packet in bigdict['packets']:
        if packet.get('ether_type') == 'ARP':
            hex_data = getHexData(packet)
            opcode = hex_data[40:44]
            packet['src_ip'] = ".".join([str(int(hex_data[i:i + 2], 16)) for i in range(56, 64, 2)])
            packet['dst_ip'] = ".".join([str(int(hex_data[i:i + 2], 16)) for i in range(76, 84, 2)])

            if opcode == "0001":  # ARP Request
                arp_requests.append(packet)
            elif opcode == "0002":  # ARP Reply
                ip_address = packet.get('src_ip', '')
                if ip_address:
                    if ip_address in arp_replies:
                        arp_replies[ip_address].append(packet)
                    else:
                        arp_replies[ip_address] = [packet]

    complete_communications = []
    partial_communications = []
    compCounter = 1
    partCounter = 1
    for request in arp_requests:
        ip_address = request.get('dst_ip', '')  # check if request dest ip is in arp_replies with reply source address
        reply = arp_replies.get(ip_address)
        if reply:
            lastrequest = None
            for check in arp_requests:  # go through all requests for this reply and get to the latest one
                if (check.get('frame_number') < reply[0].get('frame_number') and check.get('dst_ip') == reply[0].get(
                        'src_ip')):
                    lastrequest = check
            # Found an ARP pair
            comp_temp = {
                'number_comm': compCounter,
                'packets': []
            }
            request['arp_opcode'] = 'REQUEST'
            temp = reply[0]
            temp['arp_opcode'] = 'REPLY'
            # reply[0]['arp_opcode'] = 'REPLY'
            comp_temp['packets'].append(lastrequest)
            comp_temp['packets'].append(temp)
            arp_replies.pop(
                ip_address)  # if theres one reply with many requests for it, find first pair, remove reply so all other requests go to partial comms
            arp_requests.remove(lastrequest)
            complete_communications.append(comp_temp)
            compCounter += 1

        else:
            # ARP request without reply
            part_temp = None
            for part in partial_communications:
                if part['packets'][0]['dst_ip'] == request['dst_ip']:
                    part_temp = part
                    break
            if part_temp:
                request['arp_opcode'] = "REQUEST"
                part_temp['packets'].append(request)
            else:
                part_temp = {
                    'number_comm': partCounter,
                    'packets': []
                }
                request['arp_opcode'] = "REQUEST"
                part_temp['packets'].append(request)
                partial_communications.append(part_temp)
                partCounter += 1

        # Process ARP replies without corresponding requests
    for ip_address, replies in arp_replies.items():
        if ip_address not in [request.get('dst_ip', '') for request in arp_requests]:
            for reply in replies:
                part_temp = {
                    'number_comm': partCounter,
                    'packets': []
                }
                reply['arp_opcode'] = 'REPLY'
                part_temp['packets'].append(reply)
                partial_communications.append(part_temp)
                partCounter += 1

    new_dict = {
        'name': "PKS2023/24",
        'pcap_name': bigdict['pcap_name'],
        'filter_name': "ARP",
        'complete_comms': complete_communications,
        'partial_comms': partial_communications
    }
    if 'partial_comms' in new_dict and len(new_dict['partial_comms']) < 1:
        new_dict.pop('partial_comms')

    if 'complete_comms' in new_dict and len(new_dict['complete_comms']) < 1:
        new_dict.pop('complete_comms')

    return new_dict


def isFragmented(hex_data):
    ip_flags = int(hex_data[40:42], 16)
    fragment_offset = int(hex_data[40:44], 16)

    if (ip_flags) == 0:
        return False
    else:
        return True


def icmpOrder(bigdict):
    new_dict = {
        'name': "PKS2023/24",
        'pcap_name': bigdict['pcap_name'],
        'filter_name': "ICMP",
        'complete_comms': [],
        'partial_comms': []
    }
    analyzed_nodes = []
    compCounter = 1
    partCounter = 1
    complete_comms = []
    partial_comms = []
    nodes_by_id = defaultdict(list)

    for packet in bigdict['packets']:
        if packet.get('protocol') == 'ICMP':
            analyzed_nodes.append(packet)

    typ = None
    for node in analyzed_nodes:
        if(node.get('frame_number')==1696):
            print("hi")
        hex_data = getHexData(node)
        id = int(hex_data[36:40], 16)
        identifier = int(hex_data[78:80] + hex_data[76:78], 16)
        sequence = int(hex_data[82:84] + hex_data[80:82], 16)

        if isFragmented(hex_data):
            node['id'] = id
            node.pop('protocol')
            if (hex_data[68:70]) == "08":
                typ = "ECHO REQUEST"
            elif (hex_data[68:70]) == "00":
                typ = "ECHO REPLY"
            elif (hex_data[68:70]) == "03":
                node['icmp_type'] = "PORT UNREACHABLE"
            elif(hex_data[68:70])=="0b":
                node['icmp_type']="TIME EXCEEDED"
            node['flags_mf'] = True
            node['frag_offset'] = 0

        else:
            if typ != None:
                node['icmp_type'] = typ
                node['id'] = id
                node['flags_mf'] = False
                node['frag_offset'] = 1480
                typ = None
            else:
                if (hex_data[68:70]) == "08":
                    node['icmp_type'] = "ECHO REQUEST"
                elif (hex_data[68:70]) == "00":
                    node['icmp_type'] = "ECHO REPLY"
                elif (hex_data[68:70]) == "03":
                    node['icmp_type'] = "PORT UNREACHABLE"
                elif (hex_data[68:70]) == "0B":
                    print("skap")
                    node['icmp_type'] = "TIME EXCEEDED"

        node['icmp_id'] = identifier
        node['icmp_seq'] = sequence

        nodes_by_id[id].append(node)
    merged_fragmented_nodes = list(nodes_by_id.values())

    for merged_packet in merged_fragmented_nodes:
        temp = merged_packet[-1]
        if temp.get('icmp_type') != "TIME EXCEEDED" and temp.get('icmp_type') != "ECHO REPLY":
            part_temp = {
                'number_comm': partCounter,
                'packets': merged_packet
            }
            partCounter += 1
            partial_comms.append(part_temp)
            continue
        if (len(merged_packet) > 1):
            if merged_packet[1].get('icmp_type') == "ECHO REQUEST" and temp.get('icmp_type') == "ECHO REPLY" or \
                    merged_packet[1].get('icmp_type') == "ECHO REQUEST" and temp.get('icmp_type') == "TIME EXCEEDED":
                comp_temp = {
                    'number_comm': compCounter,
                    'src_comm': temp.get('dst_ip'),
                    'dst_comm': temp.get('src_ip'),
                    'packets': merged_packet
                }
                compCounter += 1
                complete_comms.append(comp_temp)
            else:
                part_temp = {
                    'number_comm': partCounter,
                    'packets': merged_packet
                }
                partCounter += 1
                partial_comms.append(part_temp)
        else:
            part_temp = {
                'number_comm': partCounter,
                'packets': merged_packet
            }
            partCounter += 1
            partial_comms.append(part_temp)

    i = 0
    temp_partial_comms = partial_comms[:]
    dlzka = len(temp_partial_comms)
    compTemp=1
    while i < (dlzka-1):
        first = temp_partial_comms[i].get('packets')[0]
        second = temp_partial_comms[i + 1].get('packets')[0]
        if len(temp_partial_comms[i].get('packets')) < 2:
            if (first.get('icmp_type') == "ECHO REQUEST" and second.get('icmp_type') == "ECHO REPLY" and
                    first.get('src_ip') == second.get('dst_ip') and first.get('dst_ip') == second.get('src_ip') or first.get('icmp_type') == "ECHO REQUEST" and
                    second.get('icmp_type') == "TIME EXCEEDED" and
                    first.get('src_ip') == second.get('dst_ip')):
                temp_partial_comms[i]['packets'].append(temp_partial_comms[i + 1].get('packets')[0])
                temp_partial_comms[i]['number_comm']=compTemp
                complete_comms.append(temp_partial_comms[i])
                partial_comms.remove(temp_partial_comms[i+1])
                partial_comms.remove(temp_partial_comms[i])
                compTemp+=1
                i += 1
        i += 1

    partTemp=1
    for i in partial_comms:
        i['number_comm']=partTemp
        partTemp+=1
    new_dict['complete_comms'] = complete_comms
    new_dict['partial_comms'] = partial_comms

    if 'partial_comms' in new_dict and len(new_dict['partial_comms']) < 1:
        new_dict.pop('partial_comms')

    if 'complete_comms' in new_dict and len(new_dict['complete_comms']) < 1:
        new_dict.pop('complete_comms')

    return new_dict


def find_dst_port(src_port, udp_nodes):
    # function that finds dst port for given src port
    for node in udp_nodes:
        if node.get('dst_port') == src_port:
            return node.get('src_port')


def compare_ports(src_port, dst_port, nodeU):
    # this function compares ports with given node ports if they belong to the same communication
    src_node = nodeU.get('src_port')
    dst_node = nodeU.get('dst_port')
    if src_port == dst_node and dst_port == src_node or src_port == src_node and dst_port == dst_node:
        return True
    return False


def isACK(packet):
    #function that checks if packet has ACKNOWLEDGE
    hexa_frame = packet.get('hexa_frame', '')
    hex_data = hexa_frame.replace(" ", "")
    hex_data = hex_data.replace("\n", "")
    if hex_data[84:88] == "0004":
        return True
    else:
        return False


def tftpOrder(bigdict):
    tftp_nodes = []
    udp_nodes = []
    complete_communications = []
    partial_communications = []

    for packet in bigdict['packets']:  # nodes with port 69 goes to tftp_nodes, other to udp_nodes
        if packet.get('ether_type') == 'IPV4' and packet.get('protocol') == "UDP":
            if packet.get('app_protocol') == "TFTP":
                tftp_nodes.append(packet)
            else:
                udp_nodes.append(packet)

    for node in tftp_nodes:
        communication = []
        src_port = node.get('src_port')
        dst_port = find_dst_port(src_port, udp_nodes)  # tries to find dst port for given tftp src port
        if dst_port is None:
            partial_communications.append(communication)
            continue
        for nodeU in udp_nodes:
            if compare_ports(src_port, dst_port, nodeU):  # if udp nodes got same src and dst port as tftp node
                communication.append(nodeU)
                src_port = nodeU.get('src_port')
                dst_port = nodeU.get('dst_port')
        communication.insert(0, node)  # insert start of communication node
        last_packet = communication[-1]
        hex_data = getHexData(last_packet)
        if isACK(last_packet):
            last_datagram_size = len(hex_data)
            agreed_block_size = 512
            if last_datagram_size < agreed_block_size:
                complete_communications.append(communication)
        else:
            partial_communications.append(communication)

    compCounter = 1
    partCounter = 1
    completed = []
    partial = []
    for comm in complete_communications:
        src_comm = comm[0].get('src_ip')
        dst_comm = comm[0].get('dst_ip')
        comp_temp = {
            'number_comm': compCounter,
            'src_comm': src_comm,
            'dst_comm': dst_comm,
            'packets': []
        }
        for packet in comm:
            comp_temp['packets'].append(packet)
        completed.append(comp_temp)
        compCounter += 1

    for comm in partial_communications:
        part_temp = {
            'number_comm': partCounter,
            'packets': []
        }
        for packet in comm:
            part_temp['packets'].append(packet)
        partial.append(part_temp)
        partCounter += 1

    new_dict = {
        'name': "PKS2023/24",
        'pcap_name': bigdict['pcap_name'],
        'filter_name': "TFTP",
        'complete_comms': completed,
        'partial_comms': partial
    }
    if 'partial_comms' in new_dict and len(new_dict['partial_comms']) < 1:
        new_dict.pop('partial_comms')

    if 'complete_comms' in new_dict and len(new_dict['complete_comms']) < 1:
        new_dict.pop('complete_comms')
    return new_dict

def ftpdOrder(bigdict):
    new_dict = {
        'name': "PKS2023/24",
        'pcap_name': bigdict['pcap_name'],
        'filter_name': "FTP-DATA",
        'packets': []
    }
    counter=0
    for packet in bigdict['packets']:
        if packet.get('ether_type')=="IPV4" and (packet.get('dst_port')==21 or packet.get('src_port')==21):
            length = packet.get('len_frame_pcap')
            hex_data = getHexData(packet)
            #if(length-14-int(hex_data[54:56],16)-int(hex_data[30:32],16))>0:
             #   new_dict['packets'].append(packet)
            if(hex_data[94:96]=='18'):
                new_dict['packets'].append(packet)
                counter+=1
    new_dict['frame_numbers']=counter
    return new_dict


pcap_file = 'eth-4.pcap'
packets = rdpcap(pcap_file)
yaml_output = "output.yml"

while (True):
    counter = 1
    bigdict = {
        'name': "PKS2023/24",
        'pcap_name': pcap_file,
        'packets': [],
        'ipv4_senders': []
    }
    print("Welcome! Please decide what you want this program to do!")
    print("ICMP - Filter out all ICMP messages and their fragments")
    print("ARP - Filter out all ARP messages")
    print("TFTP - Filter out all TFTP messages")
    print("nofilter - Prints out all messages according to tasks 1,2,3")
    print("end - Ends the program")
    user_input = input()
    for packet in packets:
        smalldict = {}
        hex_data = packet.build().hex()
        smalldict['frame_number'] = counter
        packetLength(hex_data, smalldict)
        frameType(hex_data, smalldict)
        macAdr(hex_data, smalldict)
        sapPid(hex_data, smalldict)
        ethType(hex_data, smalldict)
        srcdstIP(hex_data, smalldict)
        tcpUDP(hex_data, smalldict)
        srcdstPort(hex_data, smalldict)
        hexaDump(hex_data, smalldict)
        bigdict['packets'].append(smalldict)
        counter += 1
    ipv4count(bigdict)
    if (user_input) == "nofilter":
        with open(yaml_output, "w") as yaml_file:
            yaml = ruamel.yaml.YAML()
            yaml.dump(bigdict, yaml_file)
    elif (user_input) == "ARP":
        with open(yaml_output, "w") as yaml_file:
            new_dict = arpOrder(bigdict)
            yaml = ruamel.yaml.YAML()
            yaml.dump(new_dict, yaml_file)
    elif (user_input) == "ICMP":
        with open(yaml_output, "w") as yaml_file:
            new_dict = icmpOrder(bigdict)
            yaml = ruamel.yaml.YAML()
            yaml.dump(new_dict, yaml_file)
    elif (user_input) == "TFTP":
        with open(yaml_output, "w") as yaml_file:
            new_dict = tftpOrder(bigdict)
            yaml = ruamel.yaml.YAML()
            yaml.dump(new_dict, yaml_file)
    elif(user_input)=="FTP":
        with open(yaml_output, "w") as yaml_file:
            new_dict = ftpdOrder(bigdict)
            yaml = ruamel.yaml.YAML()
            yaml.dump(new_dict, yaml_file)
    elif (user_input) == "end":
        break
    print("output in yaml finished")
yaml_file.close()
