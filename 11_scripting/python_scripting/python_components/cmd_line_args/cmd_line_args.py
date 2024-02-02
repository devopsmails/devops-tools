# #In the below example we are *** Hard Coding *** the input
# #modules1.py

# def add(n1, n2):
#     a = n1 + n2
#     return a

# def sub(n1, n2):
#     s = n1 - n2
#     return s

# def mul(n1, n2):
#     m = n1 * n2
#     return m

# def div(n1, n2):
#     d = n1 / n2
#     return d

# print(add(1, 2))  # *** Hard Coding ***
# print(sub(4, 6))  # *** Hard Coding ***
# print(mul(3, 3))  # *** Hard Coding ***
# print(div(2, 5))  # *** Hard Coding ***

# #converting modules.py to cli_args.py:

import sys

def add(n1, n2):
    a = n1 + n2
    return a

def sub(n1, n2):
    s = n1 - n2
    return s

def mul(n1, n2):
    m = n1 * n2
    return m

def div(n1, n2):
    d = n1 / n2
    return d

n1 = float(sys.argv[1])
operator = sys.argv[2]
n2 = float(sys.argv[3])

if operator == "add":
    output = add(n1, n2)
    print(output)

if operator == "sub":
    output = sub(n1, n2)
    print(output)

if operator == "mul":
    output = mul(n1, n2)
    print(output)

if operator == "div":
    output = div(n1,n2)
    print(output)
