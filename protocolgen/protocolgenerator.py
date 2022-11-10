from protocolgen.protocolparser import ProtocolParser
import os

# load a text file from the local directory
# get the current working directory
protocol_path = f"{os.getcwd()}/light-protocol.p"

pp = ProtocolParser(protocol_path)


