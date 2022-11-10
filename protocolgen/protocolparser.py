from dataclasses import dataclass


class ProtocolParser:
    def __init__(self, protocol_path:str):
        self.protocol = self.load_protocol(protocol_path)

    def load_protocol(self, protocol_path: str):
        with open(protocol_path, "r") as f:
            return f.read().split("\n")

    def get_parsed_protocol(self) -> dict:
        # remove all white space and comments
        clean_protocol = [line for line in self.protocol if self.check_valid(line)]
        
        ###### find Variables, Actions, Commands Pairs
        
        ########### VARIABLES #############
        # Variables will be a dictionary with the variable name as the key
        # and the value as a list of variables and times that make up that variable
    
        ############ ACTIONS ##############
        # Actions will be a list of dictionaries
        # Each dictionary will have the action name as the key
        # and the contents as a list of definitions and command pairs, ordered.

        ######## COMMAND PAIRS ############
        # Commands will will be a list of dictionaries, each dictionary will have the following keys:
        #  time - the time of the command call, in milliseconds from protocol start (float)
        #  command - the command to be executed (string)
        #  variables - a list of variables that are being set by this command, if present. (list of strings)

        pass

        return [self.check_for_empty(line) for line in self.protocol]

    def check_valid(self, line:str):
        if line.strip(" ").startswith(";") or line.strip(" ") == "":
            return False
        else:
            return True
 
    def parse_line(self, line:str):
        if self.check_valid(line) == False:
            return None
        else:
            return line

