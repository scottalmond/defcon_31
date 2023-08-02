from textwrap import wrap

def convert_to_binary(morse_str):
    """
    Convert a Morse code string to binary representation.
    Args:
        morse_str (str): The input Morse code string.
    Returns:
        str: The binary representation of the Morse code string.
    """
    binary_str = ""
    for c in morse_str:
        if c == ".":
            binary_str += "10"
        elif c == "-":
            binary_str += "1110"
        else:
            binary_str += "0"
    return binary_str

def create_uintstr(binary_str, variable_name):
    """
    Create a uint8_t array string from the binary string.
    Args:
        binary_str (str): The input binary string.
        variable_name (str): The name of the uint8_t array variable.
    Returns:
        str: The uint8_t array string.
    """
    uintstr = f"uint8_t {variable_name}[] = {{"
    chunkedList = wrap(binary_str, 8)
    for index, chunk in enumerate(chunkedList):
        # Pad the chunk with zeros to make it 8 bits long
        chunk = chunk.ljust(8, '0')
        if index != len(chunkedList) - 1:
            uintstr += "0b" + chunk + ","
        else:
            uintstr += "0b" + chunk + "};"
    return uintstr

def main():
    # Input Morse code strings
    spacebitsrus_morse = "... .--. .- -.-. . -... .. - ... .-. ..- ..."
    defcon31_morse = "-.. . ..-. -.-. --- -. ...-- .----"

    # Convert Morse code to binary
    spacebitsrus_bin = convert_to_binary(spacebitsrus_morse)
    defcon31_bin = convert_to_binary(defcon31_morse)

    # Create uint8_t array strings
    uintstr_spacebitsrus = create_uintstr(spacebitsrus_bin, "morse_space")
    uintstr_defcon31 = create_uintstr(defcon31_bin, "morse_defcon")

    # Print the result
    print("Morse spacebitsrus:")
    print(uintstr_spacebitsrus)

    print("\nMorse defcon31:")
    print(uintstr_defcon31)

if __name__ == "__main__":
    main()
