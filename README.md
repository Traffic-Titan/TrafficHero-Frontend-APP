# traffic_hero

Traffic Hero APP

## Getting Started

---

# 安裝環境

## 1. 上去Flutter官網，按照步驟安裝環境 (<https://docs.flutter.dev/get-started/install>)

選擇作業系統，開始按照步驟安裝

![Alt text](/readme_image/image.png)

## 2. Flutter環境變數的設定

### - Windows

1. 在開始中找到設定

    ![Alt text](/readme_image/image-18.png )
2. 在設定中找到系統資訊

    ![Alt text](/readme_image/image-19.png)
3. 在裝置規格中點選進階系統設定

    ![Alt text](/readme_image/image-20.png)
4. 找到環境變數

    ![Alt text](/readme_image/image-21.png)
5. 在系統變數中找到Path

    ![Alt text](/readme_image/image-22.png)
6. 按編輯進入，並輸入Flutter SDK 路徑

    ![Alt text](/readme_image/image-23.png)

### - MacOS

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

Google SSO 文件需要到Firebase(<https://firebase.google.com/)下載>

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

### Google SSO 如果要在電腦上做Android 應用程式測試需要使用SHA 憑證指紋來做電腦上的驗證

1. 要先確定電腦有沒有安裝java
2. 打開CMD OR 終端機，輸入

windows

```
keytool -list -v \ -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
```

MacOS

```
keytool -list -v \ -alias androiddebugkey -keystore ~/.android/debug.keystore
```

就會得到（以下為官方文件提供之範例）

```
> Task :app:signingReport
Variant: debug
Config: debug
Store: ~/.android/debug.keystore
Alias: AndroidDebugKey
MD5: A5:88:41:04:8D:06:71:6D:FE:33:76:87:AC:AD:19:23
SHA1: A7:89:E5:05:C8:17:A1:22:EA:90:6E:A6:EA:A3:D4:8B:3A:30:AB:18
SHA-256: 05:A2:2C:35:EE:F2:51:23:72:4D:72:67:A5:6C:8C:58:22:2A:00:D6:DB:F6:45:D5:C1:82:D2:80:A4:69:A8:FE
Valid until: Wednesday, August 10, 2044
```

再到FireBase 輸入SHA指紋(只需輸入SHA1、SHA-256)

![Alt text](/readme_image/image-24.png)

## 4. 啟動虛擬機

我們找到右下方
![Alt text](/readme_image/image-15.png)

可以去選擇想要開哪個虛擬機

![Alt text](/readme_image/image-16.png)

## 5. 安裝APP

我們找到 lib/main.dart

![Alt text](/readme_image/image-17.png)

按下 F5 就會自動安裝了！

# 頁面色彩挑選規則

先選定主要色彩

{
  "hex": "#3e6fb3",
  "websafe": "#3366cc",
  "rgb": {
    "r": 62,
    "g": 111,
    "b": 179
  },
  "hsl": {
    "h": 215,
    "s": 49,
    "l": 47
  },
  "hsb": {
    "h": 215,
    "s": 65,
    "b": 70
  },
  "cmyk": {
    "c": 65,
    "m": 38,
    "y": 0,
    "k": 30
  }
}
```Color.fromRGBO(62, 111, 179, 1),```

在選定次要色
嘗試將S值設在5-10之間；B值設在95-100之間。

{
  "hex": "#e6f0ff",
  "websafe": "#ffffff",
  "rgb": {
    "r": 230,
    "g": 240,
    "b": 255
  },
  "hsl": {
    "h": 216,
    "s": 100,
    "l": 95
  },
  "hsb": {
    "h": 216,
    "s": 10,
    "b": 100
  },
  "cmyk": {
    "c": 10,
    "m": 6,
    "y": 0,
    "k": 0
  }
}
```Color.fromRGBO(230, 240, 255, 1),```
在選定輔色
增加或減少H值設定在30-40之間；並增加B值在5-10之間。

{
  "hex": "#4396bf",
  "websafe": "#3399cc",
  "rgb": {
    "r": 67,
    "g": 150,
    "b": 191
  },
  "hsl": {
    "h": 200,
    "s": 49,
    "l": 51
  },
  "hsb": {
    "h": 200,
    "s": 65,
    "b": 75
  },
  "cmyk": {
    "c": 65,
    "m": 21,
    "y": 0,
    "k": 25
  }
}
```Color.fromRGBO(67, 150, 200, 1),```

最後整體版面通過
主要色 60%
次要色 30%
輔助色 10%

以上比例進行排版


App 預覽

![Alt text](/readme_image/image25.png)