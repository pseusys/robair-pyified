from argparse import ArgumentParser
from pathlib import Path


parser = ArgumentParser()
parser.add_argument("targets", help="Targets for this launch, separated by ';'")

args = vars(parser.parse_args())

print("<launch>")
for package, node in [target.split("/") for target in args["targets"].split(";")]:
    print(f'\t<node name="{Path(node).stem}" pkg="{package}" type="{node}" output="screen" />')
print("</launch>")
