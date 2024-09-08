text = "X-DSPAM-Confidence:    0.8475"
str_start = text.rfind(":") + 1
str_end = len(text)
parsed_str = text[str_start:str_end].strip()
try:
    float_value = float(parsed_str)
    print(float_value)
except:
    print("Invalid float value")
