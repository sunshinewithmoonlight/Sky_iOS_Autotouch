import os

var1 = os.getcwd()
os.chdir(os.path.dirname(os.path.abspath(__file__)))

os.system('git pull')
os.system('git add .')
os.system('git commit -m "AutoCommit"')
os.system('git push')

os.chdir(var1)
