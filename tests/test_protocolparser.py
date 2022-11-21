from fcxyz.protocol.protocolparser import ProtocolParser
import os
import pytest


#arrange
@pytest.fixture
def get_pp():
    return ProtocolParser(f"{os.getcwd()}/fcxyz/resources/sample_protocols/light_protocol_1.p")


def test_variable_parse(pp):
    result = pp.get_variables(pp.protocol)
    assert result[0] == ("TS", "20ms")

def test_commandpair_parse(pp):
    result = pp.get_command_pairs(pp.protocol)
    assert result[0] == ("<-mfmsub_length>", "mfmsub")

def test_action_parse(pp):
    result = pp.get_actions(pp.protocol)
    assert result[0] == "SATPULSE"

pp = get_pp()
test_action_parse(pp)
test_commandpair_parse(pp)
test_variable_parse(pp)

