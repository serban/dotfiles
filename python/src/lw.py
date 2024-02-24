#!/usr/bin/env py

for w in range(72, 108, 2):
  print(f'{w:3d} {"·" * (w-6)} ■', end='\n\n')
