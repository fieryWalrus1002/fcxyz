class ScriptParser:
    def __init__(self, protocol_path):
        self.script = self.load_script(protocol_path)

    def load_script(self, protocol_path):
        with open(protocol_path, "r") as f:
            return f.read().split("\n")

    def parse_script(self):
        # parse the script
        for line in self.script:
            self.parse_line(line)

    def parse_line(self, line):
        # parse each line
        for word in line.split(" "):
            self.parse_word(word)
        print(line)



    #*

    #*