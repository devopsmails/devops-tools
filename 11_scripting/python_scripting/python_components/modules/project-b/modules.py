
functions.py
-----
```
n1 = 10
n2 = 5

def add():
    a = n1 + n2
    print(a)

def sub():
    s = n1 - n2
    print(s)

def mul():
    m = n1 * n2
    print(m)

def div():
    d = n1 / n2
    print(d)

add()
sub()
mul()
div()
```

#invoking functions in modules

#modules.py

```
import functions as calc

cal.add()
```

#creating the modules directly
#modules1.py

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
print(add(1, 2))
print(sub(4, 6))
print(mul(3, 3))
print(div(2, 5))
