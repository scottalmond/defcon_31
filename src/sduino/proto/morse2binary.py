from textwrap import wrap

spacebitsrus_morse = "... .--. .- -.-. . -... .. - ... .-. ..- ..."

spacebitsrus_bin = ""

prevMorseChar = None
for c in spacebitsrus_morse:
   if c == ".":
      spacebitsrus_bin += "10"
      prevMorseChar = "dit"
   elif c == "-":
      spacebitsrus_bin += "1110"
      prevMorseChar = "dah"
   else:
      spacebitsrus_bin += "0"
      prevMorseChar = None

print(spacebitsrus_bin)
print("SPACEBITSRUS")
print(spacebitsrus_morse)

uintstr = "uint8_t morse_space[] = {"

# Iterate over each line in the file
for line in spacebitsrus_bin:
   
   # Wrap each line into chunks of 8 characters
   chunkedList = wrap(line, 16)
   
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
print(uintstr)
