# traffic_hero

Traffic Hero APP

## Getting Started

---

# 安裝環境

## 1. 上去Flutter官網，按照步驟安裝環境 (https://docs.flutter.dev/get-started/install)
選擇作業系統，開始按照步驟安裝

![Alt text](/readme_image/image.png)

## 2. 環境變數的設定：

### - Windows :






### - MacOS : 
需要用到終端機進行環境變數設定

![Alt text](/readme_image/image-1.png)

輸入指令

```zsh
vim ~/.zshrc
```

進入到

![Alt text](/readme_image/image-2.png)

使用vim的 Insert，在鍵盤按i，就可以輸入！然後輸入 
```
export PATH="$PATH:[存放Flutter SDK 的路徑]/flutter/bin"
```
輸入後就可以按ESC退出insert模式，，之後輸入 :wq

最後再重開終端

如果要使用IOS測試：

要先安裝 Ｘcode

![Alt text](/readme_image/image-3.png)

要記得安裝CocoaPods

```
sudo gem install cocoapods
```

之後只要按照官方文件做就好！



用終端機直接輸入就好


### VScode Flutter 安裝

![Alt text](/readme_image/image-4.png)

在工具列上找到延伸工具

搜尋 flutter

![Alt text](/readme_image/image-5.png)

找到後直接安裝就好！




# 啟用本專案

## 1. 先上github下載本專案

## 2. 使用VScode打開本專案

## 3. 安裝套件
打開終端機，輸入
```
flutter pub get
```
就可以安裝套件

## 4. 下載ENV、Google SSO驗證文件
Google SSO 文件需要到Firebase(https://firebase.google.com/)下載

進到網站並點進專案中我們可以看的

![Alt text](/readme_image/image-6.png)

這兩個是Android、IOS得文件

點擊後我們會看到設定按鈕

![Alt text](/readme_image/image-7.png)

進到設定我們往下滑

![Alt text](/readme_image/image-8.png)

裡面有個

![Alt text](/readme_image/image-9.png)
![Alt text](/readme_image/image-10.png)

分別是兩個文件的Google SSO 驗證文件

下載後我們到VScode中丟進去

Android：

![Alt text](/readme_image/image-11.png)

要丟在 android/app 這個路徑底下

IOS：

在IOS文件夾點右鍵

![Alt text](/readme_image/image-12.png)

找到Open in Xcode並點擊

![Alt text](/readme_image/image-13.png)

找到Runner並點擊右鍵找到 Add File to 'Runner'

![Alt text](/readme_image/image-14.png)

選擇驗證文件按確定就好了

## 4. 啟動虛擬機

我們找到右下方
![Alt text](/readme_image/image-15.png)

可以去選擇想要開哪個虛擬機

![Alt text](/readme_image/image-16.png)

## 5. 安裝APP

我們找到 lib/main.dart

![Alt text](/readme_image/image-17.png)

按下 F5 就會自動安裝了！