from zxtouch.client import zxtouch
from zxtouch.touchtypes import *
from zxtouch.toasttypes import *
import os, sys
import time
os.chdir(os.path.dirname(os.path.abspath(__file__)))

def main(a, b):
    main.device = zxtouch("127.0.0.1")
    v1= ""
    while True:
        v2= ""
        if float(main.device.pick_color(a[0], b[0])[1]["blue"])>150.0: v2= "%sA1" %v2
        if float(main.device.pick_color(a[0], b[1])[1]["blue"])>150.0: v2= "%sA2" %v2
        if float(main.device.pick_color(a[0], b[2])[1]["blue"])>150.0: v2= "%sA3" %v2 
        if float(main.device.pick_color(a[0], b[3])[1]["blue"])>150.0: v2= "%sA4" %v2 
        if float(main.device.pick_color(a[0], b[4])[1]["blue"])>150.0: v2= "%sA5" %v2 
        if float(main.device.pick_color(a[1], b[0])[1]["blue"])>150.0: v2= "%sB1" %v2 
        if float(main.device.pick_color(a[1], b[1])[1]["blue"])>150.0: v2= "%sB2" %v2 
        if float(main.device.pick_color(a[1], b[2])[1]["blue"])>150.0: v2= "%sB3" %v2 
        if float(main.device.pick_color(a[1], b[3])[1]["blue"])>150.0: v2= "%sB4" %v2 
        if float(main.device.pick_color(a[1], b[4])[1]["blue"])>150.0: v2= "%sB5" %v2 
        if float(main.device.pick_color(a[2], b[0])[1]["blue"])>150.0: v2= "%sC1" %v2 
        if float(main.device.pick_color(a[2], b[1])[1]["blue"])>150.0: v2= "%sC2" %v2 
        if float(main.device.pick_color(a[2], b[2])[1]["blue"])>150.0: v2= "%sC3" %v2 
        if float(main.device.pick_color(a[2], b[3])[1]["blue"])>150.0: v2= "%sC4" %v2 
        if float(main.device.pick_color(a[2], b[4])[1]["blue"])>150.0: v2= "%sC5" %v2

        if v2=="":  v2=". "
        else:       v2= "%s " %v2
        v1="%s%s" %(v1, v2)

        if float(main.device.pick_color(236, 647)[1]["blue"])<1.0:  break

        main.device.touch(TOUCH_DOWN, 5, 450, 1100)
        main.device.touch(TOUCH_UP, 5, 450, 1100)
        time.sleep(0.1)


    v3=str(time.time())+".txt"
    with open(v3, encoding="utf-16-le", mode="w") as f:
        f.write("\ufeff<DontCopyThisLine> 600 0 16 Unknown Unknown\n%s\n" %v1)
        
    main.device.run_shell_command("chown 501 \"%s\"" %os.path.abspath(v3))
    main.device.disconnect()

main([370, 500, 620], [870, 760, 630, 510, 380])









