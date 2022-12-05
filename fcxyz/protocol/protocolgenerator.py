from protocol import (
    LightValue,
    TimeValue,
    ProtocolBlock,
    Protocol,
)

if __name__ == "__main__":
    test_protocol = Protocol(
        name="test_protocol",
        description="test protocol",
        protocol_blocks=[
            ProtocolBlock(
                name="light teatment",
                section_label="pre-illumination",
                period=TimeValue(30, "s"),
                light=LightValue(70, 70),
                check_points=None,
            ),
            ProtocolBlock(
                name="Fmprime",
                section_label="Fmprime",
                period=TimeValue(30, "s"),
                light=LightValue(70, 70),
                sat_pulse=True,
                pulse_duration=TimeValue(0.8, "s"),
                check_points=["Fo_L1", "Fm_L1"],
            ),
            ProtocolBlock(
                name="Fmprime",
                section_label="Fmprime",
                period=TimeValue(30, "s"),
                light=LightValue(70, 70),
                sat_pulse=True,
                pulse_duration=TimeValue(0.8, "s"),
                check_points=["Fo_Lss", "Fm_Lss"],
            ),
            ProtocolBlock(
                name="light after pulse",
                section_label="light after pulse",
                period=TimeValue(10, "s"),
                light=LightValue(0, 0),
                check_points=None
            ),

            ProtocolBlock(
                name="foprime",
                far_red=True,
                period=TimeValue(10, "s"),
                light=LightValue(0, 0),
                check_points=[
                    "Foprime",
                ],
            ),
            ProtocolBlock(
                name="recovery",
                period=TimeValue(30, "s"),
                light=LightValue(0, 0),
                sat_pulse=True,
                pulse_duration=TimeValue(0.8, "s"),
                far_red=False,
                check_points=["Ft_D1", "Fm_D1"],
            ),
            ProtocolBlock(
                name="recovery",
                period=TimeValue(30, "s"),
                light=LightValue(0, 0),
                far_red=False,
                sat_pulse=True,
                pulse_duration=TimeValue(0.8, "s"),
                check_points=["Ft_D2", "Fm_D2"],
            ),
            ProtocolBlock(
                name="recovery",
                period=TimeValue(30, "s"),
                light=LightValue(0, 0),
                far_red=False,
                sat_pulse=True,
                pulse_duration=TimeValue(0.8, "s"),
                check_points=["Ft_D3", "Fm_D3"],
            ),
            ProtocolBlock(
                name="recovery",
                period=TimeValue(60, "s"),
                light=LightValue(0, 0),
                sat_pulse=True,
                pulse_duration=TimeValue(0.8, "s"),
                far_red=False,
                check_points=["Ft_D4", "Fm_D4"],
            ),
            ProtocolBlock(
                name="recovery",
                period=TimeValue(60, "s"),
                light=LightValue(0, 0),
                sat_pulse=True,
                pulse_duration=TimeValue(0.8, "s"),
                far_red=False,
                check_points=["Ft_D5", "Fm_D5"],
            ),
            ProtocolBlock(
                name="dark",
                section_label="dark",
                period=TimeValue(10, "s"),
                light=LightValue(0, 0),
                check_points=None
            ),
        ],
    )

    protocol_string = test_protocol.serialize()
    print(protocol_string)

    with open("test_protocol.p", "w") as f:
        f.write(protocol_string)
