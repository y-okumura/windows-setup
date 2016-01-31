# windows上の環境構築をできる限りchocolateyで

## インストール方法

```
choco pack wildfly\wildfly.nuspec
cinst -y -s "http://chocolatey.org/api/v2/;%cd%" packages.config trial.config
```

## 入れるもの

* 開発回り
 * docker + docker-machine + virtualbox
 * jdk
 * groovy
 * maven
 * NetBeans
 * Atom
 * sublimetext3 + PackageControl
 * chrome
 * github desktop
* フォント
 * Source Code PRO

# 入れたいけどまだ入れれてないもの

* フォント
 * JPAフォント
 * [Notoフォント](http://www.google.com/get/noto/help/cjk/) :  https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
 * ricty
* 設定
 * Atomのフォント  
 ~\.atom\styles.lessを書き換え
```less:
atom-text-editor {
  font-family: 'Noto Sans Mono CJK JP', monospace;
}
atom-workspace {
  font-family: 'Noto Sans CJK JP', meiryo;
}
```
 * スクロールの向き
   HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\HID\xxxxx\yyyyy\Device Parameters のFlipFlopWheelおよびFlipFlopHScrollを1にする。  
   xxxxxおよびyyyyyの部分はハードウェアによって異なる。
 * 左command = ctrl
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout に新規バイナリ値「Scancode Map」を作成し、以下の値を設定
```
00 00 00 00
00 00 00 00
02 00 00 00
e0 5b 00 1d
00 00 00 00
```
