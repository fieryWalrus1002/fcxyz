import unittest
from protocolgen.generator import ProtocolGenerator

class TestProtoGenerator(unittest.TestCase):
    def test_init(self):
        pg = ProtocolGenerator("./sample_protocols/test_light_protocol.p")
        # TS=20ms first line
        self.assertEqual(pg.protocol, ["; test protocol", ""])