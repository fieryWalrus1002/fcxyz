class ProtocolParser:
    def __init__(self, protocol_path:str):
        self.protocol = self.load_protocol(protocol_path)

    def load_protocol(self, protocol_path: str):
        with open(protocol_path, "r") as f:
            return f.read().split("\n")

    def get_parsed_protocol(self) -> list[str]:
        # parse the protocol
        # find definitions
        # fine Action definitions
        # find time definitions
        # find commands
        # Then return as a dictionary of the following format:
        # {
        #   "definitions": {
        #       "name": "value"
        #   },
        #   "actions": {
        #       "name": {
        #           "time": "value",
        #           "commands": ["command1", "command2"]
        #       }
        #   }
        # }
        pass

        return [self.parse_line(line) for line in self.protocol]

    def parse_line(self, line:str):
        for word in line.split(" "):
            self.parse_word(word)
 


# cases

definitions:

    #*

    #*