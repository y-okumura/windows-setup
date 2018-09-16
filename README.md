# windows上の環境構築をできる限りchocolateyで

## インストール方法

setup.batを右クリックして、「管理者として実行」する。

## 入れるもの

setup.ps1の`$packages`および`WindowsFeatures`を参照。

 - PowerShell編集用
   - windows-sdk-10.0
   - vscode
 - 仮想化
   - docker-for-windows
   - vagrant
 - Java関係
   - jdk8
   - jdk10
   - groovy
   - maven
   - NetBeans
 - エディタ
   - atom
   - SublimeText3
   - SublimeText3.PackageControl
 - ブラウザ
   - GoogleChrome
 - GitHub
   - github-desktop
 - フォント
   - sourcecodepro
 - Windowsの機能
   - Windows subsystem for linux
   - Hyper-v
   - Windows Server コンテナー

# 入れたいけどまだ入れれてないもの

 - フォント
   - JPAフォント
   - [Notoフォント](http://www.google.com/get/noto/help/cjk/) :  https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
   - ricty
 - 設定
   - Atomのフォント  
 ~\.atom\styles.lessを書き換え
```less:
atom-text-editor {
  font-family: 'Noto Sans Mono CJK JP', monospace;
}
atom-workspace {
  font-family: 'Noto Sans CJK JP', meiryo;
}
```
   - スクロールの向き
     HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\HID\xxxxx\yyyyy\Device Parameters のFlipFlopWheelおよびFlipFlopHScrollを1にする。  
     xxxxxおよびyyyyyの部分はハードウェアによって異なる。
   - 左command = ctrl
     HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout に新規バイナリ値「Scancode Map」を作成し、以下の値を 設定
     ```
     00 00 00 00
     00 00 00 00
     02 00 00 00
     e0 5b 00 1d
     00 00 00 00
     ```

# たぶんスクリプトではできないもの

仮想化サポートをオンにする。

BIOSのマシンの場合、PCの起動時（再起動時にはうまくできない場合あり）にF2（またはF3, F4, Fn+F2など。メーカーのサポートページなどで確認）を押してBIOS設定画面に入り、

IntelのCPUの場合:

 - Advanced > CPU Configuration >  Execute Disable Bit > [Enabled]   
 - Advanced > CPU Configuration >  Intel(R) VirtualizationTechnology > [Enabled]

AMD系のCPUの場合：

 - Advanced > CPU Configuration >　SVM > [Enabled]

に設定する。

## Macにwindowsを入れる場合は、

仮想化を有効にするためにはUEFIで入れる必要があるとの情報があり、
また複数のパーティションを認識させるためにもEFIで起動する必要があるため、
以下の点に注意してセットアップしている。

（以下MacにUEFIでwindowsを入れるためのメモ）  
- BOOTCAMPでパーティションを作成しない。MBRが作成されてしまいEFIとならない。
- Disk Utilityでwindows用のフォーマット（FAT32 ~~およびおそらくExFATも~~ExFATは大丈夫だった模様 ）のパーティションを作成してもMBRが作成されてしまう。
- インストーラをEFIで起動しないとMBRを見に行こうとしてしまってうまくインストールができない。  

以上から、

1. DiskUtilityではいったんMac OS 拡張などの形式でパーティションを作成し、
2. BOOTCAMPユーティリティで作成したwindowsのインストーラUSBを差してOptionを押しながら立ち上げてEFIブートで起動したうえで
3. windowsのインストーラでインストール先のパーティションをフォーマットしなおしてインストールする。

また、別の情報によれば、mac osXの起動ディスクの設定でwindowsを選択していないと仮想化が有効にならないという情報もあり、  
実際いったん mac osX で起動ディスクの設定を行うまでは仮想化が有効になっていなかった。  
実際にはEFIかどうかは関係なく、起動ディスクで選択すれば仮想化が有効になるのかもしれないが、未検証。
