import protocolgen.protocolelements
import unittest


class TestProtocolParser(unittest.TestCase):

    def test_math(self):
        self.assertEqual('foo'.upper(), 'FOO')

if __name__ == '__main__':
    unittest.main()