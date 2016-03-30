require './normalizer'

READ_DIRECTORY = "../data/v1/schools/**/**.yml"
WRITE_FILE = "../dist/schools.json"

parser = Normalizer::Parser.new(directory: READ_DIRECTORY)
parser.save_to!(filename: WRITE_FILE)

puts "File saved to %s" % WRITE_FILE