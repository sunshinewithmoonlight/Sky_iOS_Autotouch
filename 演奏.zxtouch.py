from zxtouch.client import zxtouch
from zxtouch.touchtypes import *
from zxtouch.toasttypes import *
import os, sys
import random
import time
import gc
gc.disable()
os.chdir(os.path.dirname(os.path.abspath(__file__)))

def m2(a):
    s= a.split(" ")
    q=[]
    s3_len= 0
    s3_lenThis= 0
    s3_endIndex= 0

    # 保证屏幕旋转后进行对应的按键位置旋转（仅在解析按键的位置时有效）
    x= int(float(main.device.get_screen_size()[1]['width']))
    y= int(float(main.device.get_screen_size()[1]['height']))

    # device.get_screen_orientation()[1]   '4'充电口向左，'3'充电口向右
    s6= int(main.device.get_screen_orientation()[1])
    s6_1= (2*s6-7)*(2*main.head_to_right-1)
    s6_2= abs(3-s6+main.head_to_right)

    for i in s:
        s2= []
        s2_pre= []
        s3_lenThis= 0
        if i !="." and i != "":
            for i2 in range(len(i)//2):
                s4_0= i[2*i2]
                s4_1= i[2*i2+1]
                s5_x= 0
                s5_y= 0

                if s4_0== "A":
                    s5_x= main.x[0] *s6_1+s6_2*x
                elif s4_0== "B":
                    s5_x= main.x[1] *s6_1+s6_2*x
                elif s4_0== "C":
                    s5_x= main.x[2] *s6_1+s6_2*x

                if s4_1== "1":
                    s5_y= main.y[0] *s6_1+s6_2*y
                elif s4_1== "2":
                    s5_y= main.y[1] *s6_1+s6_2*y
                elif s4_1== "3":
                    s5_y= main.y[2] *s6_1+s6_2*y
                elif s4_1== "4":
                    s5_y= main.y[3] *s6_1+s6_2*y
                elif s4_1== "5":
                    s5_y= main.y[4] *s6_1+s6_2*y
                
                s3_len +=1
                s3_lenThis +=1
                s3_endIndex = s3_len % 9+1

                s2.append({"type": TOUCH_DOWN, "finger_index": s3_endIndex, "x": s5_x, "y": s5_y})
                s2_pre.append({"type": TOUCH_UP, "finger_index": s3_endIndex, "x": s5_x, "y": s5_y})

        q.append(s2)
        q.append(s2_pre)
    
    # print(q)
    return q

def m3(a1_q, a2_rate):
    s= 30000000//int(a2_rate)
    for i in a1_q:
        main.device.touch_with_list(i)
        main.device.accurate_usleep(s)


def main(x, y):
    main.device = zxtouch("127.0.0.1")

    main.x=x
    main.y=y
    main.head_to_right=(x[-1]-x[0]>0)
    
    s3= os.listdir()

    # 随机播放
    random.shuffle(s3)
    
    for i in s3:
        if i[-4:]==".txt":
            with open(i, mode='r', encoding='utf-16-le') as f:
                main.device.show_toast(TOAST_MESSAGE, os.path.basename(i), 1.5)
                s= f.readlines()
                s2= s[0].split(" ")[1]
                try:
                    q= m2( s[1] )
                    m3(q, s2)
                except:
                    print("可能%s不是Sky Studio生成的ABC谱" %i)
                    main.device.show_toast("An error has occurred, please check the log")

    main.device.disconnect()


main([160, 330, 460], [960, 810, 670, 520, 370])
# 在这里修改触摸位置，从上到下、从左到右依次记录3x5=15个键















