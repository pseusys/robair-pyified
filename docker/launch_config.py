from xml.etree.ElementTree import parse
from argparse import ArgumentParser
from pathlib import Path
from shutil import copyfile
from sys import exit, stderr


parser = ArgumentParser()
parser.add_argument("file", help="Target file (will be written if '-s' provided and checked if '-c' provided)")
parser.add_argument("-c", "--check", help="'rosnode list' output, will be checked whether all the nodes in provided file are launched")
parser.add_argument("-s", "--source", help="Sources for this launch, string separated by ':' OR a launch file name (should be under sources root and have '.launch' extension)")

args = vars(parser.parse_args())
target_file = Path(args["file"])

if args["check"] is not None:
    if not target_file.is_file():
        raise Exception(f"Target file '{target_file}' can not be read!")
    for node in [node.attrib["name"] for node in parse(target_file).iter("node")]:
        assert node in args["check"], f"Node '{node}' not found in provided list '{args['check']}'!"

elif args["source"] is not None:
    source_file = Path("./src/" + args["source"])
    if target_file.is_file() and target_file.suffix == ".launch":
        copyfile(source_file, target_file)
    else:
        with target_file.open("w") as file:
            file.write("<launch>")
            for package, node in [target.split("/") for target in args["source"].split(":")]:
                file.write(f'\t<node name="{Path(node).stem}" pkg="{package}" type="{node}" output="screen" />')
            file.write("</launch>")

else:
    parser.print_help(stderr)
    exit(1)
