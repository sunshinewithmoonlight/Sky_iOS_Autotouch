# 光遇自动弹琴

## 介绍

需要有根越狱（rootful）的iOS设备，希望大家弹琴开心

## autotouch 使用教程

- 此 autotouch 脚本适配 iPhone 5/5s/se 的屏幕，其他尺寸自行适配

1. Jailbreak（rootful）参考<https://ios.cfw.guide/archived-palera1n-rootful/>
    ```
    palera1n -B -f
    或
    palera1n -c -f
    ```

2. 安装 autotouch

    添加以下源（谢谢毛子！）：
    
    ```
    https://ellekit.space/
    https://rpetri.ch/repo/
    https://rejail.ru/
    ```
    搜索autotouch（和filza）并安装。

3. 新建脚本。将“演奏.autotouch.lua”文件内容复制到脚本中，命名为“sky.lua”。

4. 用filza等文件管理软件把sky studio直接导出的ABC谱（UTF16LE格式）复制到“sky.lua”位置的新建文件夹“SkyMusicScore”中。

5. 进游戏放大琴键后，长按音量下键，选择并运行脚本

## autotouch 独立曲谱版使用教程

这个是针对未授权版的autotouch，一次运行两分钟。用的时候修改脚本里的曲谱内容和速度（gap）。

## zxtouch 使用教程

- 此 zxtouch 脚本适配 iPhone 6/6s/7/8/se2 的屏幕，其他尺寸自行适配

1. Jailbreak（<=iOS14, rootful）

2. 安装zxtouch（<=iOS14, rootful）

    Cydia源失效了，我放到了这个仓库的Release里，试试能不能用

3. 新建脚本。将“演奏.zxtouch.py”文件内容复制到“main.py”中

4. 用filza等文件管理软件把sky studio直接导出的ABC谱（UTF16LE格式）复制到“main.py”同一个文件夹

    脚本的文件夹在 /var/mobile/Library/ZXTouch/scripts

    建议把不需要弹奏的谱子另外建一个文件夹方便来回移动

4. 在Cydia中安装Activator软件，设置脚本的触发条件（比如长按音量上键）

5. 运行脚本

    可以用zxtouch的触摸显示器显示脚本是否正常运行（略微降低点击性能）

## 其他

- zxtouch暂不支持乐谱文件名中的unicode或中文字符，会显示乱码

- Unc0ver 6.1.2 版本bug导致触动精灵的触摸服务无法启动。安装6.2.0版本可解决

- 小王子季更新：增加了乐器无法快速弹奏的bug，会漏掉音符，好友靠近时甚至还会误触而停止演奏，现已无此问题

- `palera1n --force-revert -f`清除越狱后，需要手动重启一遍再越狱
