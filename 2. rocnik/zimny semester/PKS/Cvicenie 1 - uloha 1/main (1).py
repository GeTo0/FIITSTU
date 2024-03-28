from ruamel.yaml.scalarstring import PreservedScalarString
from scapy.all import rdpcap
import ruamel.yaml

pcap_file = 'trace-26.pcap'
packets = rdpcap(pcap_file)
yaml_output = "output.yml"
counter = 1

EthTypes = {
    8192: "CDP",
    8196: "DTP",
    267: "PVSTP+",
    2203: "AppleTalk"
}

SAPs = {
    0: "Null SAP",
    2: "LLC Sublayer Management / Individual",
    3: "LLC Sublayer Management / Group",
    6: "IP",
    14: "PROWAY Network Management, Maintenance and Installation",
    78: "MMS",
    94: "ISI IP",
    126: "X.25 PLP",
    142: "PROWAY Active Station List Maintenance",
    170: "SNAP",
    224: "IPX",
    244: "LAN Management",
    254: "ISO Network Layer Protocols",
    255: "Global DSAP",
    240: "NETBIOS",
    66: "STP",
}


def packetLenght(packet):
    length = len(packet)
    return length


def mediaPacketLenght(packet):
    mLength = len(packet) + 4
    return mLength


def destinationMacAdress(packet):
    a = packet[0:2]
    b = packet[2:4]
    c = packet[4:6]
    d = packet[6:8]
    e = packet[8:10]
    f = packet[10:12]
    # macadr = f"{int(a,16)}.{int(b,16)}.{int(c,16)}.{int(d,16)}.{int(e,16)}.{int(f,16)}"
    macadr = f"{a}:{b}:{c}:{d}:{e}:{f}"
    return macadr


def sourceMacAdress(packet):
    a = packet[12:14]
    b = packet[14:16]
    c = packet[16:18]
    d = packet[18:20]
    e = packet[20:22]
    f = packet[22:24]
    # macadr = f"{int(a,16)}.{int(b,16)}.{int(c,16)}.{int(d,16)}.{int(e,16)}.{int(f,16)}"
    macadr = f"{a}:{b}:{c}:{d}:{e}:{f}"
    return macadr


def frameType_length(packet):
    ethtype = packet[24:28]
    sap_pid_val = None
    if (int(ethtype, 16) >= 1500):  # 1535
        frame_type = "Ethernet II"
    else:
        data4_pole = packet[28:30]
        if (data4_pole == "aa"):
            frame_type = "IEEE 802.3 LLC & SNAP"
            llcEthtype = packet[40:44]
            if EthTypes.get(int(llcEthtype, 16)) == None:
                llcEthtype = packet[92:96]
            sap_pid_val = EthTypes.get(int(llcEthtype, 16))

        elif (data4_pole == "ff"):
            frame_type = "IEEE 802.3 RAW"

        else:
            frame_type = "IEEE 802.3 LLC"
            data_SAP = hex_data[30:32]
            sap_pid_val=SAPs.get(int(data_SAP, 16))

    return frame_type, sap_pid_val


def hexData(hex_data):
    hexd = hex_data.hex()
    return hexd

def format_hex_string(hex_data):
    hexDataFinal = ""
    counter2=1
    for pismeno in hex_data:
        hexDataFinal += pismeno
        if counter2 % 2 == 0 and counter2 % 32 != 0:
            hexDataFinal += ' '
        elif counter2 % 32 == 0:
            hexDataFinal += '\n'
        counter2 += 1
    return hexDataFinal

def frame_to_dict(counter, len_pcap, len_med_pcap, frame_type, macadr_src, macadr_dst, hex_data, sap_pid_value):
    frame_dict = {}
    hex_data = PreservedScalarString(hex_data)
    if(sap_pid_value == None):
        frame_dict = {
            'frame_number': counter,
            'len_frame_pcap': len_pcap,
            'len_frame_medium': len_med_pcap,
            'frame_type': frame_type,
            'src_mac': macadr_src,
            'dst_mac': macadr_dst,
            'hexa_frame': hex_data,
        }
    elif sap_pid_value in EthTypes.values():

        frame_dict = {
            'frame_number': counter,
            'len_frame_pcap': len_pcap,
            'len_frame_medium': len_med_pcap,
            'frame_type': frame_type,
            'src_mac': macadr_src,
            'dst_mac': macadr_dst,
            'pid': sap_pid_value,
            'hexa_frame': hex_data,
        }
    elif sap_pid_value in SAPs.values():
        frame_dict = {
            'frame_number': counter,
            'len_frame_pcap': len_pcap,
            'len_frame_medium': len_med_pcap,
            'frame_type': frame_type,
            'src_mac': macadr_src,
            'dst_mac': macadr_dst,
            'sap': sap_pid_value,
            'hexa_frame': hex_data,
        }
    return frame_dict


with open(yaml_output, "w") as yaml_file:
    smalldict={}
    bigdict = {
        'name': "PKS2023/24",
        'pcap_name': pcap_file,
        'packets': []
    }

    for packet in packets:
        hex_data = packet.build().hex()
        len_pcap = packetLenght(hex_data)
        len_med_pcap = mediaPacketLenght(hex_data)
        frame_type, sap_pid_value = frameType_length(hex_data)
        macadr_src = sourceMacAdress(hex_data)
        macadr_dst = destinationMacAdress(hex_data)

        new_hex_data = format_hex_string(hex_data).upper()
        smalldict = frame_to_dict(counter, len_pcap, len_med_pcap, frame_type, macadr_src, macadr_dst, new_hex_data,sap_pid_value)

        bigdict['packets'].append(smalldict)
        counter += 1

    yaml = ruamel.yaml.YAML()
    yaml.dump(bigdict,yaml_file)