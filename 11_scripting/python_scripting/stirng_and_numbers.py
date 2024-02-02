#01-Sting-concat
str1 = "Hello"
str2 = "World"
result = str1 + " " + str2
print(result)

#02-len of object

text = "Python is awesome"
length = len(text)
print("Length of the string:", length)

#03-Uppercase or lowercase

text = "Python is awesome"
uppercase = text.upper()
lowercase = text.lower()
print("Uppercase:", uppercase)
print("Lowercase:", lowercase)

#04-String replace

text = "Python is awesome"
new_text = text.replace("awesome", "great")
print("Modified text:", new_text)

#05-string_split
text = "Python is awesome"
words = text.split()
print("Words:", words)

#06-string_strip

text = "   Some spaces around   "
stripped_text = text.strip()
print("Stripped text:", stripped_text)

#07-substring
text = "Python is awesome"
substring = "is"
if substring in text:
    print(substring, "found in the text")

#08 Float
# Float variables
num1 = 5.0
num2 = 2.5

# Basic Arithmetic
result1 = num1 + num2
print("Addition:", result1)

result2 = num1 - num2
print("Subtraction:", result2)

result3 = num1 * num2
print("Multiplication:", result3)

result4 = num1 / num2
print("Division:", result4)

# Rounding
result5 = round(3.14159265359, 2)  # Rounds to 2 decimal places
print("Rounded:", result5)

#09 # Integer variables
num1 = 10
num2 = 5

# Integer Division
result1 = num1 // num2
print("Integer Division:", result1)

# Modulus (Remainder)
result2 = num1 % num2
print("Modulus (Remainder):", result2)

# Absolute Value
result3 = abs(-7)
print("Absolute Value:", result3)

#10 
