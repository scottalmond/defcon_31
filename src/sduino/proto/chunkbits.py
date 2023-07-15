from textwrap import wrap

filename = "spacebitsrus.txt"

with open(filename) as file:
    lines = [line.rstrip() for line in file]

uintstr = "uint8_t compressed[] = {"
for line in lines:
   chunkedList = wrap(line, 8)
   i = 0
   for chunk in chunkedList:
      i += 1
      if len(chunk) < 7:
         chunk += "00"
      uintstr += "0b" + chunk + ","
   print(i)
uintstr += "}"

print(uintstr)