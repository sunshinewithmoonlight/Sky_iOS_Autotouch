"auto"
//setScreenMetrics(1280, 720);
/*
if(device.sdkInt>28){
    //等待截屏权限申请并同意
    threads.start(function () {
        packageName('com.android.systemui').text('立即开始').waitFor();
        text('立即开始').click();
    });
}
//申请截屏权限
if (!requestScreenCapture()) {
    toast("请求截图失败");
    exit()
}
*/

x=[440, 550, 680, 800, 920];
y=[430, 550, 670];



function getThisKeys(){
    var result = shell("screencap -p /sdcard/1.jpg", true);
    var nowScreen = images.read("/sdcard/1.jpg");
    //var nowScreen = captureScreen();
    let thisKeys = ""
    let ifEnd = false
    if (colors.blue(images.pixel(nowScreen, x[0], y[0]))>150){ thisKeys = thisKeys + "A1" }
    if (colors.blue(images.pixel(nowScreen, x[1], y[0]))>150){ thisKeys = thisKeys + "A2" }
    if (colors.blue(images.pixel(nowScreen, x[2], y[0]))>150){ thisKeys = thisKeys + "A3" }
    if (colors.blue(images.pixel(nowScreen, x[3], y[0]))>150){ thisKeys = thisKeys + "A4" }
    if (colors.blue(images.pixel(nowScreen, x[4], y[0]))>150){ thisKeys = thisKeys + "A5" }
    if (colors.blue(images.pixel(nowScreen, x[0], y[1]))>150){ thisKeys = thisKeys + "B1" }
    if (colors.blue(images.pixel(nowScreen, x[1], y[1]))>150){ thisKeys = thisKeys + "B2" }
    if (colors.blue(images.pixel(nowScreen, x[2], y[1]))>150){ thisKeys = thisKeys + "B3" }
    if (colors.blue(images.pixel(nowScreen, x[3], y[1]))>150){ thisKeys = thisKeys + "B4" }
    if (colors.blue(images.pixel(nowScreen, x[4], y[1]))>150){ thisKeys = thisKeys + "B5" }
    if (colors.blue(images.pixel(nowScreen, x[0], y[2]))>150){ thisKeys = thisKeys + "C1" }
    if (colors.blue(images.pixel(nowScreen, x[1], y[2]))>150){ thisKeys = thisKeys + "C2" }
    if (colors.blue(images.pixel(nowScreen, x[2], y[2]))>150){ thisKeys = thisKeys + "C3" }
    if (colors.blue(images.pixel(nowScreen, x[3], y[2]))>150){ thisKeys = thisKeys + "C4" }
    if (colors.blue(images.pixel(nowScreen, x[4], y[2]))>150){ thisKeys = thisKeys + "C5" }
    if (colors.blue(images.pixel(nowScreen, 656, 207))<10){ ifEnd = true }
    //toast(thisKeys);
    return [thisKeys, ifEnd];
}
keys = ""
var [key, ifEnd] = getThisKeys()
if (key==""){
    keys += ". "
} else {
    keys = keys + key + " "
}

while(!ifEnd){
    click(260, 450);
    [key, ifEnd] = getThisKeys()

    if (key==""){
        keys += ". "
    } else {
        keys = keys + key + " "
    }
}
console.log(keys)
//files.write("/sdcard/"+ (Math.random() + 1).toString(36).substring(7) +".txt", keys);


