
from dataclasses import dataclass

@dataclass
class Variable:
    """ ########### VARIABLES #############
    # Variables are a dataclass that contains the name of the variable, and 
    # a list of variables and times that define that variable.  
    """
    name: str
    variables: list


@dataclass
class Action:
    """ ############ ACTIONS ##############
    # Actions are a dataclass that contains the name of the action, and 
    # a list of definitions and command pairs, ordered.
    """
    name: str
    definitions: list
    commands: list

@ dataclass
class CommandPair:
    """ ######## COMMAND PAIRS ############
    # CommandPairs are a dataclass that contains the time of the command call, 
    # in milliseconds from protocol start (float), the command to be executed (string),
    # and a list of variables that are being set by this command, if present. (list of strings)
    """
    time: float
    command: str
    variables: list


### section labels for readability
# There are section labels for dividing the protocol into broad categories, and for readability. These are not required, but are useful for organizing the protocol. The section labels are:
# ```{protocol}
# ;--------------------------------------------------------------------------------------
# ;******* Dark Relaxation Measurement **************************************************
# ;--------------------------------------------------------------------------------------
# ````
# Three lines, first line is a semicolor followed by x dashes, second line is the section label placed inside of a left and right buffer of asterisks, with one space on either side of the label. The third line is the same as the first line.

@dataclass
class SectionLabel:
    """ 
    Section labels are a dataclass that contains the name of the section, and when the
    section is printed, it will produce a string with multiple lines, first line is a semicolor followed by x dashes,
    second line is the section label placed inside of a left and right buffer of asterisks, with one space on either side of the label.
    The third line is the same as the first line.
    """
    name: str
    char_count: int = 88

    def __repr__(self) -> str:
        return self._get_label()

    def _get_label(self) -> str:
        return f";{'-'*self.char_count}\n;{'*'*int(0.5*self.char_count - len(self.name))} {self.name} {'*'*int(0.5*self.char_count - len(self.name))}\n;{'-'*self.char_count}"

    def __str__(self):
        return self._get_label()