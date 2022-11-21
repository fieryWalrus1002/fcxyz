import json
# import requests
import pandas as pd
import numpy as np
import datetime
import os
from protocolparser import ProtocolParser

# load a text file from the local directory
# get the current working directory
protocol_path = "./protocolgen/resources/sample_protocols/test_protocol_light.p"

pp = ProtocolParser(protocol_path)

protocol = ProtocolParser(protocol_path)

protocol.parse_script()
