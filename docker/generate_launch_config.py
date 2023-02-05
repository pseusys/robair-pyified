import os
from argparse import ArgumentParser
from pathlib import Path


parser = ArgumentParser()
parser.add_argument("targets", help="Targets for this launch, separated by ';' OR a launch file name (should be under sources root and have '.launch' extension)")

args = vars(parser.parse_args())

target_file = Path("./src/" + args["targets"])
if target_file.is_file() and target_file.suffix == ".launch":
    print(target_file.read_text())
else:
    print("<launch>")
    for package, node in [target.split("/") for target in args["targets"].split(";")]:
        print(f'\t<node name="{Path(node).stem}" pkg="{package}" type="{node}" output="screen" />')
    print("</launch>")
