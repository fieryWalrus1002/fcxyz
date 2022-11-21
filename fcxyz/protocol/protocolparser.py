"""@ protocolparser
    This module hold the ProtocolParser class, which takes in a protocol and parses it into its components. """
from dataclasses import dataclass
import re


class ProtocolParser:
    """ The ProtocolParser class does the work of chopping a text protocol *.p file into a list of individual elements.

    Parameters
    ----------
    protocol_path : str
        A path to a *.p file that will be parsed.

    """ 
    def __init__(self, protocol_path:str) -> None:
        self.protocol = self.load_protocol(protocol_path)

    def load_protocol(self, protocol_path: str):
        with open(protocol_path, "r") as f:
            return f.read()


    def get_parsed_protocol(self) -> dict:
        # remove all white space and comments
        return [line for line in self.protocol if self.check_valid(line)]
        

        ###### find Variables, Actions, Commands Pairs
        
        ########### VARIABLES #############
        # Variables will be a dictionary with the variable name as the key
        # and the value as a list of variables and times that make up that variable
        variables = self.get_variables(clean_protocol)

        ############ ACTIONS ##############
        # Actions will be a list of dictionaries
        # Each dictionary will have the action name as the key
        # and the contents as a list of definitions and command pairs, ordered.
        actions = self.get_actions(clean_protocol)

        ######## COMMAND PAIRS ############
        # Commands will will be a list of dictionaries, each dictionary will have the following keys:
        #  time - the time of the command call, in milliseconds from protocol start (float)
        #  command - the command to be executed (string)
        #  variables - a list of variables that are being set by this command, if present. (list of strings)
        command_pairs = self.get_command_pairs(clean_protocol)

        # return [self.check_for_empty(line) for line in self.protocol]
        return {}

    def get_variables(self, protocol:list) -> list:
        var_pattern = r"([a-zA-z0-9]+)\s*=\s*(\d+[s|ms]*);*"
        return re.findall(var_pattern, protocol, flags=re.MULTILINE|re.IGNORECASE|re.X)

    def get_actions(self, protocol:list) -> list:
        action_pattern = r"(Action\s*)([A-Za-z0-9]+\s*)(\(.+\))*(\s*begin(\s|\r)+)*"
        # action = []
        # for line in protocol:
        #     if re.match(action_pattern, line):
        #         action.append(line)
        return re.findall(action_pattern, protocol, flags=re.MULTILINE|re.IGNORECASE|re.X|re.DOTALL)

    def get_command_pairs(self, protocol:list) -> list:
        # command pattern fits this:
        # Action MEASURE(end_time) begin
        # <800ms + 2*mfmsub_length,800ms + 2*mfmsub_length + 130 * mfmsub_length ..end_time - mfmsub_length>=>mfmsub
        # end
        command_pattern = r".+"
        return re.findall(command_pattern, protocol, flags=re.MULTILINE|re.DOTALL|re.X)


        """
        if line.strip(" ").startswith(";") or line.strip(" ") == "":
            return False
        else:
            return True
 
    def parse_line(self, line:str) -> str or None:
        """ parses a line, returning it if it is valid or none if not

        returns
        -------
        str or None
        """ 

        if self.check_valid(line) == False:
            return None
        else:
            return line

