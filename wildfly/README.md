# 使用方法

    choco pack
してから

    cinst wildfly -y -s %cd%
する。

<code>choco pack</code>の引数にgae-goフォルダまでのパスを渡せば、このフォルダの配下でなくてもインストールできる。
