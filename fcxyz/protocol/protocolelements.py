"""This module contains the elements of a Fluorcam7 *.p protocol file, which details the how and when of device actions. These actions can be flashing the saturation pulse, capturing data at a particular time, and labeling the data with text markers for later use during analysis.

"""
from dataclasses import dataclass


@dataclass
class LightValue:
    blue: int
    red: int

    @property
    def act1(self):
        return self.red

    @property
    def act2(self):
        return self.blue


@dataclass
class TimeValue:
    value: float
    unit: str

    @property
    def time(self):
        return self._calulate_time()

    @property
    def time_string(self):
        return f"{self.value}{self.unit}"

    def _calulate_time(self):
        if self.unit == "m":
            return self.value * 60.0
        elif self.unit == "s":
            return self.value
        elif self.unit == "ms":
            return self.value / 1000.0
        else:
            raise ValueError(f"Invalid time unit {self.unit}")


@dataclass
class Variable:
    """A dataclass that contains a paired variable name and a list of its assigned values.

    Parameters:
    -----------
    name : str
        The name of the variable.
    values : list
        A list of values that are assigned to the variable. Joined by arithmetic operators."""

    name: str
    values: list

    def stringify(self):
        return f"{self.name} = {''.join(self.values)}\n"


@dataclass
class Action:
    """Actions are a dataclass that contains the name of the action, and a list of variables and command pairs, ordered."""

    name: str
    variables: list
    commands: list

    def stringify(self):
        action_str = f"Action {self.name} begin\n"

        for variable in self.variables:
            action_str += variable.stringify()

        for command in self.commands:
            action_str += command.stringify()

        action_str += "end\n\n"


@dataclass
class CommandPair:
    """CommandPairs are a dataclass that contains the time of the command call, in milliseconds from protocol start (float), the command to be executed (string), and a list of variables that are being set by this command, if present. (list of strings)"""

    time: float
    command: str
    variables: list = None

    def stringify(self):
        if self.variables is not None:
            return f"<{self.time}>=>{self.command}({''.join(self.variables)})\n"
        else:
            return f"<{self.time}>=>{self.command}\n"


@dataclass
class SectionLabel:
    """Section labels are a dataclass that contains the name of the section, and when the section is printed, it will produce a string with multiple lines, first line is a semicolor followed by x dashes,
    second line is the section label placed inside of a left and right buffer of asterisks, with one space on either side of the label. The third line is the same as the first line.

    """

    name: str
    char_count: int = 88

    def __repr__(self) -> str:
        return self._get_label()

    def _get_label(self) -> str:
        return f";{'-'*self.char_count}\n;{'*'*int(0.5*self.char_count - len(self.name))} {self.name} {'*'*int(0.5*self.char_count - len(self.name))}\n;{'-'*self.char_count}"

    def __str__(self):
        return self._get_label()
