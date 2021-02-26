import argparse
import codecs
import nltk
from nltk import tokenize


nltk.download('punkt')
tokenizer = nltk.data.load('tokenizers/punkt/spanish.pickle')

arg_parser = argparse.ArgumentParser( description = "Copy source_file as single sentences in target_file." )
arg_parser.add_argument( "source_file" )
arg_parser.add_argument( "target_file" )
arguments = arg_parser.parse_args()

source = arguments.source_file
target = arguments.target_file

fp = open(source)
data = fp.read()
sentences = nltk.sent_tokenize(data)

fout = open(target, 'w')
#print ('\n'.join(tokenizer.tokenize(data)))
fout.write('\n'.join(tokenizer.tokenize(data)))
fout.close()
