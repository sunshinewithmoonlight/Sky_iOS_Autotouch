# 光遇自动弹琴（基于zxtouch）

## 介绍

基于免费的zxtouch。

在触动精灵上运行的lua脚本由于不支持多点同时触控，已经停止支持。

目前适配了 iPhone 6s 的屏幕，
有需求可以提 Issues 或 Pull request。

目前版本的一系列弹奏bug（例如漏音）仍然存在，已经通过zxtouch的多点同时触控支持实现快速弹奏。

## 安装教程

1. Jailbreak

2. 安装zxtouch

    Cydia源：https://zxtouch.net/

3. 新建脚本。将“演奏.zxtouch.py”文件内容复制到“main.py”中

4. 用filza等文件管理软件把sky studio导出的ABC谱（UTF16LE格式）复制到“main.py”同一个文件夹

    脚本的文件夹在 /var/mobile/Library/ZXTouch/scripts

    建议把不需要弹奏的谱子另外建一个文件夹方便来回移动

4. 在Cydia中安装Activator软件，设置脚本的触发条件（比如长按音量上键）

5. 运行脚本

    可以用zxtouch的触摸显示器显示脚本是否正常运行（略微降低点击性能）

## Bug记录

- zxtouch暂不支持乐谱文件名中的unicode或中文字符，会显示乱码

- Unc0ver 6.1.2 版本bug导致触动精灵的触摸服务无法启动。安装6.2.0版本可解决

- 小王子季更新：增加了乐器无法快速弹奏的bug，会漏掉音符，好友靠近时甚至还会误触而停止演奏

    - 8.19更新：听起来爽多了，基本都能连起来，应该是没有漏音了。需要注意的是弹奏时的网络环境很重要，听的人的网络环境也是

## 致谢

### 迷迭超帅，迷迭巨帅，迷迭世界第一帅！
