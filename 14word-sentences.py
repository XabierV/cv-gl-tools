import argparse

arg_parser = argparse.ArgumentParser( description = "Copy source_file sentences with 14 words or less in target_file." )
arg_parser.add_argument( "source_file" )
arg_parser.add_argument( "target_file" )
arguments = arg_parser.parse_args()

source = arguments.source_file
target = arguments.target_file

fp = open(source,'r')
fout = open(target, 'w')

for line in fp.readlines():
    words = line.split()
    if len(words) < 15:
        fout.write(line)

fout.close()
