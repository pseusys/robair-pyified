from argparse import ArgumentParser
from pathlib import Path


parser = ArgumentParser()
parser.add_argument("file", help="Target file (will be written if '-s' provided and checked if '-c' provided)")
parser.add_argument("-s", "--source", help="Sources for this launch, string separated by ':'")
parser.add_argument("-i", "--include", help="Source for this launch, a launch file package and file name (separated by '/' character)")

args = vars(parser.parse_args())
target_file = Path(args["file"])

with target_file.open("w") as file:
    file.write("<launch>\n")

    if args["include"] is not None:
        file.write(f'\t<include file="{args["include"]}"/>\n')

    if args["source"] is not None:
        for package, node in [target.split("/") for target in args["source"].split(":")]:
            file.write(f'\t<node name="{node}" pkg="{package}" type="{node}" output="screen" />\n')

    file.write("</launch>\n")
