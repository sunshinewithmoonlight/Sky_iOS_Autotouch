import os, sys, json, time, gc
gc.disable()

def main(a):
    #os.chdir(os.path.dirname(os.path.abspath(a)))
    main.abc= ""
    main.abc_i= 0
    main.spot= []
    try:
        with open(a, encoding="utf-16-le", mode="r") as f:
            v= json.loads(f.read()[1:])
    except Exception as e:
        print(a, "：可能是ABC谱或其他不能识别的文件")
    if v[0]["name"]=="Untitle":
        v2_name= os.path.basename(a)[:-4]
    else:
        v2_name= v[0]["name"]
    v5_bpm= v[0]["bpm"]
    v5_gap= 60000//v5_bpm
    v6_song= v[0]["songNotes"]
    
    if v6_song[0]["time"]==0:
        main.abc="."
    for i in v6_song:
        if i["key"][0]=="2":
            v7= i["time"]//v5_gap
            v9= int(i["key"].split('y')[1])
            v8= ".".join((v7-main.abc_i)*[" "])
            main.abc_i= v7
            main.abc= "%s%s%s%s" %( main.abc, v8, chr(ord('A')+v9//5), v9%5+1 )
    
    with open(os.path.join(main.dir, v2_name+".txt"), encoding="utf-16-le", mode="w") as f:
        f.write("\ufeff<DontCopyThisLine> %s %s %s %s %s\n%s\n" %(v5_bpm, v[0]["pitchLevel"], v[0]["bitsPerPage"], v[0]["author"], v[0]["transcribedBy"], main.abc))


if __name__ == "__main__":
    if len(sys.argv[1:]) ==0:
        print("参数应为JS谱的文件路径")
        sys.exit()
    print("因为未知蓝键的转换逻辑，将不保留蓝键")
    main.dir= "ABC.%s" %time.time()
    os.mkdir(main.dir)
    for i in sys.argv[1:]:
        i= i.strip('\'\"\\').rstrip('/')
        main(i)