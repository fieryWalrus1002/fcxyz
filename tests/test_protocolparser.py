import unittest
from protocolgen.protocolparser import ProtocolParser

class TestProtoParser(unittest.TestCase):
    def test_init(self):
        pp = ProtocolParser("./sample_protocols/test_light_protocol.p")
        # TS=20ms first line
        self.assertEqual(pp.protocol, ["; test protocol", ""])

class ExpectedFailureTestCase(unittest.TestCase):
    @unittest.expectedFailure
    def test_fail(self):
        self.assertEqual(1, 0, "broken")