"""
Chunk Bits

This script reads a file, chunks up the bits, and generates a C-style array of compressed data.

Usage:
python chunkbits.py --file <filename>

"""

import argparse
from textwrap import wrap

# Parse command-line arguments
parser = argparse.ArgumentParser()
parser.add_argument('--file', type=str, required=True)
args = parser.parse_args()

# Get the filename from command-line arguments
filename = args.file

# Read the file and remove trailing whitespaces from each line
with open(filename) as file:
    lines = [line.rstrip() for line in file]

# Initialize the string for the compressed data array
uintstr = "uint8_t compressed[] = {"

# Iterate over each line in the file
for line in lines:
   
   # Wrap each line into chunks of 8 characters
   chunkedList = wrap(line, 8)
   
   # Variable to store the number of line breaks in the array
   linebreakinterval = 0
   
   # Iterate over each chunk in the chunked list
   for i, chunk in enumerate(chunkedList):
      linebreakinterval += 1
      
      # Append '00' to the chunk if its length is less than 7
      if len(chunk) < 7:
         chunk += "00"
      
      # Determine if the chunk is the first or last element in the array
      #if i in {0, len(chunkedList)-1}:
      #   uintstr += "0b" + chunk + "};"
      #else:
      uintstr += "0b" + chunk + ","
   
# Print the number of line breaks in the array
print("int linebreakinterval = " + str(linebreakinterval))

# Print the compressed data array
print(uintstr)


