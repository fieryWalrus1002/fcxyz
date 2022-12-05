import subprocess
import os
import argparse

# ./compiler -i ./include -o debug.log ./protocols/Quenching-without-FR1-LU-Mic.p


def compile(output_file, protocol_file):
    """compiles a protocol file and saves debug output to given file"""
    try:
        subprocess.check_output(
            [
                f"fc7/compiler",
                "-i",
                "fc7/Include",
                "-do",
                f"{output_file}",
                f"{protocol_file}",
            ]
        )
    except Exception as e:
        print("Error compiling protocol: ", e)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-p",
        "--protocol",
        help="path to the protocol file to compile",
        default="test_protocol.p",
    )
    parser.add_argument(
        "-o",
        "--output",
        help="output log file name",
        default="debug.log",
    )

    args = parser.parse_args()
    compile(args.output, args.protocol)
