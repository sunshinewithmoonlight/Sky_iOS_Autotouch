
import os, sys

def m(a):
  with open(a,mode='r',encoding='utf-16-le') as f:
    s= f.read()
  with open(a,mode='w',encoding='utf8') as f:
    f.write(s)

if __name__ == "__main__":
  if len(sys.argv[1:]) ==0:
    print("")
    sys.exit()
  for i in sys.argv[1:]:
    i= i.strip('\'\"\\').rstrip('/')
    m(i)
