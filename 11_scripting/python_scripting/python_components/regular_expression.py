
#01-to find all
import re

text = "The quick brown fox"
pattern = r"brown"

search = re.search(pattern, text)
if search:
    print("Pattern found:", search.group())
else:
    print("Pattern not found")

#02-matchall

import re

text = "The quick brown fox"
pattern = r"quick"

match = re.match(pattern, text)
if match:
    print("Match found:", match.group())
else:
    print("No match")

#03-replace
    
import re

text = "The quick brown fox jumps over the lazy brown dog"
pattern = r"brown"

replacement = "red"

new_text = re.sub(pattern, replacement, text)
print("Modified text:", new_text)

#04-search

import re

text = "The quick brown fox"
pattern = r"brown"

search = re.search(pattern, text)
if search:
    print("Pattern found:", search.group())
else:
    print("Pattern not found")

#05-split

import re

text = "apple,banana,orange,grape"
pattern = r","

split_result = re.split(pattern, text)
print("Split result:", split_result)
