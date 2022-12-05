import datetime
from protocolelements import LightValue, TimeValue
from dataclasses import dataclass
import random


@dataclass
class Protocol:
    name: str
    description: str
    protocol_blocks: list
    section_delimeter: str = f";{'*'*25}\n"
    time_step: TimeValue = TimeValue(20, "ms")
    pulse_duration = TimeValue(800, "ms")
    light_value = LightValue(70, 60)
    protocol_type: str = "light"
    shutter: int = 3
    sensitivity: int = 52
    far: int = 75
    satpulse_intensity: int = 90

    def serialize(self):
        block_zero_time = 0.0
        block_string_list = []

        for block in self.protocol_blocks:

            block_string = block.serialize(block_zero_time)
            block_string_list.append(block_string)
            print(f"time{block_zero_time} {block.duration}")
            block_zero_time += block.duration

        return (
            self.include_old_header()
            + self.include_old_actions()
            + "\n".join(block_string_list)
            + "\n;end"
        )

    def include_header(self) -> str:
        return "\n".join(
            [
                "TS=20ms",
                "include default.inc;",
                "include light.inc;",
                f";------------------------------------------------",
                f";protocol: {self.name}",
                f";notes: {self.description}",
                f";created: {datetime.datetime.now()}",
                f";------------------------------------------------",
                "Shutter=3",
                "Sensitivity=52",
                f"Act1={self.light_value.red}",
                f"Act2={self.light_value.blue}",
                f"Super={self.satpulse_intensity}",
                "\n",
            ]
        )

    def include_old_header(self) -> str:
        return "\n".join(
            [
                ";protocol body - modified by ZB",
                ";version November 18, 2010",
                ";high-resolution CCD",
                "TS=50ms",
                "include default.inc  ;Includes standard options, do not remove it !",
                "include light.inc  ;Includes standard options, do not remove it !",
                f"Shutter={self.shutter}",
                f"Sensitivity={self.sensitivity}",
                f"FAR={self.far}",
                ";----actinic light set to 160uE, combination of red and blue. Both at 45%",
                f"Act1={self.light_value.red}",
                f"Act2={self.light_value.blue}",
                f"Super={self.satpulse_intensity}",
            ]
        )

    def include_actions(self) -> str:
        """returns a string of the actions to be included in the protocol"""
        time_step = self.time_step.time_string

        return "\n".join(
            [
                ";------------------------------------------------",
                ";-----------------  Actions --------------------",
                ";------------------------------------------------",
                "Action SATPULSE(end_time) begin",
                "<-mfmsub_length>=>mfmsub",
                f"<0s>=>act1({self.pulse_duration.time_string})",
                f"<0s>=>act2({self.pulse_duration.time_string})",
                "<0s,TS + 2 * mfmsub_length .. end_time>=>mfmsub",
                "<end_time + mfmsub_length>=>mfmsub",
                "end",
                "Action FARRED_MEASURE(end_time) begin",
                f"<0s, {time_step}, .. end_time - mfmsub_length>=>FAR({time_step} - 2*mfmsub_length)",
                f"<{time_step} - 2*mfmsub_length, {time_step}, .. end_time - mfmsub_length>=>mfmsub",
                "end",
                "Action MEASURE(end_time) begin",
                f"<{time_step} - 2*mfmsub_length, {time_step}, .. end_time - mfmsub_length>=>mfmsub",
                "end",
                "\n",
                ";------------------------------------------------",
                ";--------------  Start Protocol -----------------",
                ";------------------------------------------------",
                "\n",
            ]
        )

    def include_old_actions(self) -> str:
        """returns a string of the actions to be included in the protocol"""
        time_step = self.time_step.time_string

        return "\n".join(
            [
                ";************************************************************************************************************",
                "Action SATPULSE(end_time) begin",
                " <-mfmsub_length>=>mfmsub ;before pulse",
                " <0s>=>SatPulse(800ms)",
                " <TS,TS + 2 * mfmsub_length .. 800ms/2 - mfmsub_length>=>mfmsub",
                " <800ms/2,800ms/2 + mfmsub_length .. 800ms>=>mfmsub",
                " <800ms + mfmsub_length>=>mfmsub",
                "end",
                ";",
                "Action MEASURE(end_time) begin",
                "  <800ms + 2*mfmsub_length,800ms + 2*mfmsub_length + 40 * mfmsub_length ..end_time - mfmsub_length>=>mfmsub",
                "end",
                ";",
                "Action FARREDILL(end_time) begin",
                "  <800ms + 4*mfmsub_length,800ms + 4*mfmsub_length + 40 * mfmsub_length ..end_time - 2 * mfmsub_length>=>FAR(38*mfmsub_length)",
                "end",
                ";\n",
            ]
        )


@dataclass
class ProtocolBlock:
    name: str = "block"
    section_label: str = ""
    period: TimeValue = TimeValue(0, "s")
    light: LightValue = LightValue(70, 60)
    far_red: bool = False
    check_points: list = None
    pulse_duration: TimeValue = TimeValue(0.0, "s")
    block_zero_time: float = 0.0
    sat_pulse: bool = False

    @property
    def duration(self) -> float:
        """calculates the duration of the block in seconds"""
        print(f"duration {self.period.time + self.pulse_duration.time}")
        return self.period.time + self.pulse_duration.time

    @property
    def meas_start(self) -> float:
        """calculates the time at which the measurement should start"""
        return self.block_zero_time

    @property
    def meas_time(self) -> float:
        """calculates the time that the measurement should last"""
        return self.period.time - 1

    @property
    def pulse_start(self) -> float:
        """calculates the time at which the pulse should start"""
        return self.block_zero_time + self.period.time

    @property
    def pulse_end(self) -> float:
        """calculates the time at which the pulse should end"""
        return self.pulse_start + self.pulse_duration.time

    def serialize(self, block_zero_time: float):
        """returns a string representation of the protocol block"""
        self.block_zero_time = block_zero_time

        return f";{self.name}\n" + self._get_pulse_string()

    def _get_pulse_string(self) -> str:
        """returns a string representation of a pulse in the protocol block"""

        pulse_string_list = [self.get_section_label()]

        command_pairs = [
            self.get_actinic_light_actions(),
            self.get_measurment_action(),
            self.get_satpulse_action(),
        ] + self.get_check_points()

        return "\n".join(pulse_string_list + command_pairs)

    def get_actinic_light_actions(self) -> str:
        if self.light.red > 0 or self.light.blue > 0:
            return "\n".join(
                [
                    f"<{self.meas_start}s>=>act1({self.meas_time}s);",
                    f"<{self.meas_start}s>=>act2({self.meas_time}s);",
                ]
            )
        else:
            return ""

    def get_satpulse_action(self):
        if self.sat_pulse:
            return f"<{self.pulse_start}s>=>SATPULSE({self.pulse_duration.time}s);\n"
        else:
            return ""

    def get_measurment_action(self):
        if self.far_red == True:
            return f"<{self.meas_start}>=>FARREDILL({self.meas_time}s)\n<{self.meas_start}s>=>MEASURE({self.meas_time}s);\n"
        else:
            return f"<{self.meas_start}s>=>MEASURE({self.meas_time}s);\n"

    def get_section_label(self):
        if self.section_label is not None:
            return "\n".join(
                [
                    f";-------------------------------------------------------------------------------------------------------------",
                    f";*** {self.section_label} {'*' * (105 - len(self.section_label))}",
                    f";-------------------------------------------------------------------------------------------------------------\n",
                ]
            )
        else:
            return ""

    def get_check_points(self):
        out_list = []

        if self.check_points is not None:
            for check_point in self.check_points:
                if self.checkpoint_contains(check_point, ["Fo", "Fs", "Ft"]):
                    out_list.append(
                        f'<{round(self.pulse_start - 0.5 * self.meas_time, 2)}s>=>checkPoint,"start{check_point}"'
                    )
                    out_list.append(
                        f'<{self.pulse_start - round(random.random(), 2)}s>=>checkPoint,"end{check_point}"'
                    )

                if self.checkpoint_contains(check_point, ["Fm"]):
                    out_list.append(
                        f'<{self.pulse_start}s>=>checkPoint,"start{check_point}"'
                    )
                    out_list.append(
                        f'<{self.pulse_end}s>=>checkPoint,"end{check_point}"'
                    )

        return out_list

    def checkpoint_contains(self, string, substrings):
        for substring in substrings:
            if substring in string:
                return True
        return False


# ;-------------------------------------------------------------------------------------------------------------
# ;*** Saturating Pulse & Fm Measurement ***********************************************************************
# ;-------------------------------------------------------------------------------------------------------------
# PulseDuration = 800ms;      ##
# PulseStart = F0duration + 2*mfmsub_length;      ##
# ;
# <PulseStart>=>SATPULSE
# <PulseStart>=>act1(PulseDuration)
# <PulseStart>=>act2(PulseDuration)
# ;
# <PulseStart + PulseDuration/2>=>checkPoint,"startFm"
# <PulseStart + PulseDuration - mfmsub_length>=>checkPoint,"endFm"
# ;
# ;Visual frame definition                                                  Image shown in pre-processing window
# <PulseStart + PulseDuration - 3*mfmsub_length>=>checkPoint,"timeVisual"
# ;

# ;*******Fast Kautsky kinetics*****************************************
# <ALStart - 2*mfmsub_length>=>mfmsub
# <ALStart, ALStart + mfmsub_length .. EndFp - 2*mfmsub_length>=>mfmsub
# ;
# ;Fp definition
# <ALStart>=>checkPoint,"startFp"
# <EndFp>=>checkPoint,"endFp"


# ;******* Saturating Pulses in Light- Fm_L'********************************************************************
# ;
# ;pulse 1
# <24.8s>=>SATPULSE
# <24.8s - mfmsub_length>=>checkPoint,"startFt_L1"
# <24.8s + PulseDuration/2>=>checkPoint,"startFm_L1"
# <24.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_L1"
# ;
# ;1 to 2 pulses
# <24.8s>=>MEASURE(61.1 - 24.8s)
# ;2 pulses
# <61.1s>=>SATPULSE
# <61.1s - mfmsub_length>=>checkPoint,"startFt_L2"
# <61.1s + PulseDuration/2>=>checkPoint,"startFm_L2"
# <61.1s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_L2"
# ;
# ;2 to 3 pulses
# <61.1s>=>MEASURE(97.5 - 61.1)
# ;3
# <97.5s>=>SATPULSE
# <97.5s - mfmsub_length>=>checkPoint,"startFt_L3"
# <97.5s + PulseDuration/2>=>checkPoint,"startFm_L3"
# <97.5s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_L3"
# ;
# ;from 3 to 4
# <97.5s>=>MEASURE(133.8 - 97.5)
# ;4
# <133.8s>=>SATPULSE
# <133.8s - mfmsub_length>=>checkPoint,"startFt_Lss"
# <133.8s + PulseDuration/2>=>checkPoint,"startFm_Lss"
# <133.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_Lss"

# ******* Saturating Pulses in Dark- Fm_D'********************************************************************
# ;
# ;pulse 1
# <144.8s>=>SATPULSE
# <144.8s>=>act1(PulseDuration)
# <144.8s>=>act2(PulseDuration)
# <144.8s - mfmsub_length>=>checkPoint,"startFt_D1"
# <144.8s + PulseDuration/2>=>checkPoint,"startFm_D1"
# <144.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D1"
# ;from 1 to 2
# <144.8s>=>MEASURE(181.1 - 144.8s)
# ;2
# <181.1s>=>SATPULSE
# <181.1s>=>act1(PulseDuration)
# <181.1s>=>act2(PulseDuration)
# <181.1s - mfmsub_length>=>checkPoint,"startFt_D2"
# <181.1s + PulseDuration/2>=>checkPoint,"startFm_D2"
# <181.1s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D2"
# ;from 2 to 3
# <181.1s>=>MEASURE(217.5 - 181.1s)
# ;3
# <217.5s>=>SATPULSE
# <217.5s>=>act1(PulseDuration)
# <217.5s>=>act2(PulseDuration)
# <217.5s - mfmsub_length>=>checkPoint,"startFt_D3"
# <217.5s + PulseDuration/2>=>checkPoint,"startFm_D3"
# <217.5s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D3"
# ;from 3 to 4
# <217.5s>=>MEASURE(253.8 - 217.5s)
# ;4
# <253.8s>=>SATPULSE
# <253.8s>=>act1(PulseDuration)
# <253.8s>=>act2(PulseDuration)
# <253.8s - mfmsub_length>=>checkPoint,"startFt_D4"
# <253.8s + PulseDuration/2>=>checkPoint,"startFm_D4"
# <253.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D4"

# FoMeasureStart=253.8s + PulseDuration + 2*mfmsub_length
# FoPeriod=60s
# <FoMeasureStart>=>MEASURE(FoPeriod)
# <FoMeasureStart>=>FARREDILL(FoPeriod)
# FoPrimeStart=FoMeasureStart+FoPeriod
# <FoPrimeStart - 2*TS>=>checkPoint,"startFoPrime"
# <FoPrimeStart>=>checkPoint,"endFoPrime"
# ;;;;;;
