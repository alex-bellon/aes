#write code here
from optparse import OptionParser
parser = OptionParser()
parser.add_option('--keysize', action='store', type='int', dest='keysize')
parser.add_option('--keyfile', action='store', type='string', dest='keyfile')
parser.add_option('--inputfile', action='store', type='string', dest='inputfile')
parser.add_option('--outputfile', action='store', type='string', dest='outputfile')
parser.add_option('--mode', action='store', type='string', dest='mode')
(options, args) = parser.parse_args();

print(options.keysize)
