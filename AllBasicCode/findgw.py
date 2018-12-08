import os
import sys

for dirpath, dirnames, filenames in os.walk('.'):
    for name in filenames:
        if not name.lower().endswith('.bas'):
            continue
        file = os.path.join(dirpath, name)
        with open(file, 'rb') as f:
            first = f.read(1)
        if first in b'0123456789\xfe\xff':
            print(file)

