import json
import requests
import pandas as pd
import numpy as np
import datetime
import os
from script_parser import ScriptParser

# load a text file from the local directory
# get the current working directory
protocol_path = f"{os.getcwd()}/light-protocol.p"

sp = ScriptParser(protocol_path)

sp.parse_script()
