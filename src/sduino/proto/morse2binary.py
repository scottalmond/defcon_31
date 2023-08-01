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

chunkedList = wrap(spacebitsrus_bin, 8)
      
# Iterate over each chunk in the chunked list
for i, chunk in enumerate(chunkedList):      
   # Append '00' to the chunk if its length is less than 7
   if len(chunk) < 7:
      chunk += "00"
      
   uintstr += "0b" + chunk + ","
print(uintstr)
