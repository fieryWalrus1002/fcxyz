"""@ protocolparser
    This module hold the ProtocolParser class, which takes in a protocol and parses it into its components. """
from dataclasses import dataclass


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
            return f.read().split("\n")


    def get_parsed_protocol(self) -> list:
        """ Takes the loaded protocol and returns the parsed protocol, minus white space and comment lines. 

        Returns
        -------
        list[str]
        """
        # remove all white space and comments
        return [line for line in self.protocol if self.check_valid(line)]
        

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

        # return [self.check_valid(line) for line in self.protocol]

    def check_valid(self, line:str) -> bool:
        """ checks to see if an input string is a comment or blank

        returns
        -------
        bool

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

