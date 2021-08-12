import collections
import os, sys
import time
import re

def m(a):
  with open(a, encoding='utf8', mode='r') as f:
    v=f.read()
  v3=['A1','A2','A3','A4','A5','B1','B2','B3','B4','B5','C1','C2','C3','C4','C5']
  v2 = re.findall(r'function ([^t][0-9])\(\)', v)
  v5 = re.findall(r'function (t[0-9])\(\)', v)

  v2=v2[:15]
  v6_trans= dict(zip(v2,v3))
  print("转换时间间隔，通常应填写：t1=2 (\" . . \") , t2=1 (\" . \") , t3=4 (\" . . . . \") , t4=0 (\" \")")
  v12=""
  for i in range(len(v5)):
    v14=int(input("%s = " %v5[i]))
    v6_trans[v5[i]]= " %s " %' '.join(v14*['.'])
    if v14==0:
      v12=v5[i]
    if v14==1:
      v13=v5[i]
  if v12!="":
    v15=input("建议把两个连续的%s项替换为%s，要这样做吗？([y]/n)" %(v12, v13))
    if v15=="" or v15=="y" or v15=="Y":
      v=v.replace("%s();%s();" %(v12,v12), "%s();" %(v13))
  # print(v6_trans) 

  v8=re.compile(r'([a-zA-Z][0-9])\(\);')
  v9=v8.findall(v)
  # print(v9)
  v10=[v6_trans[i] for i in v9]
  v11= ''.join(v10).replace('  ', ' ')
  print(v11)
  rate= int(60000/int(input("音节时间间隔（毫秒） = ")))
  with open("%s.txt" %os.path.basename(a)[:-3], mode='w', encoding='utf-16-le') as f:
    f.write("\ufeff<DontCopyThisLine> %s 0 16 Unknown Unknown\n%s\n" %(rate, v11))


if __name__ == "__main__":
  if len(sys.argv[1:]) ==0:
    print("")
    sys.exit()
  for i in sys.argv[1:]:
    i= i.strip('\'\"\\').rstrip('/')
    if i[-3:]==".js":
      try:
        os.chdir(os.path.dirname(os.path.abspath(i)))
        m(i)
      except Exception as e:
        print(e)
        input()
