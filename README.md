# dotfiles

## WSL用ノート

### ターミナル

`wsltty`を利用。

### コンテキストメニュー追加

Windowsスタートメニュー -> WSLtty -> add to ...

### sshエージェント

`ssh-agent`は別セッション間でシェアするのは面倒くさそうなので`weasel-pageant`を使う。  

https://github.com/vuori/weasel-pageant

releaseからzipをダウンロードしてきてWindows側のディレクトリに解凍（`C:\weasel-pageant` など）  
`.bashrc`に`eval $(/path/to/weasel-pageant -r)`を追加すればpageantに追加してあるキーを見てくれるようになる。

### wslショートカット

`C:\Users\ユーザー名\AppData\Local\wsltty\bin\mintty.exe --WSL= --configdir="C:\Users\ユーザー名\AppData\Roaming\wsltty" -~`

### 他

`explorer.exe .`でカレント作業ディレクトリだけはWindowsエクスプローラーで開ける様子。  
特定の場所をファイル選択状態で開くような方法はまだ不明。 2019/08/22

## vim

### ale+phpmd

phpmd導入はこちらのサイトさんの解説が分かりやすい。

[https://blog-ja.sideci.com/entry/2017/06/27/110000](https://blog-ja.sideci.com/entry/2017/06/27/110000)

1. `composer`インストール
2. `composer global require "phpmd/phpmd=@stable"`
3. `~/.composer/vendor/bin/phpmd` か `~/.config/composer/vendor/bin/phpmd` あたりにphpmdがインストールされる
4. binが置かれた場所にパスを通して`phpmd`コマンドが使えるようにしておく。 `export PATH=$PATH:~/.config/composer/vendor/bin`

(たぶんシンプルXML拡張モジュールが要るかも?)  
`sudo apt-get install php-xml`  

vimからLintが動いてるかテストするには`:!phpmd % text unusedcode.xml`のようにする。(phpmdは引数が3つ必要）  

## cygwin用ノート

### コンテキストメニュー追加

`chere -ian -e "bash here" -t mintty -s bash`  

`i - Install`  
`a - All users`  
`n - Be nice ?`  
`e <menutext>`  
`t <term>`  
`s <shell>`  

### コンテキストメニュー削除

`chere -u`

### 特定の作業ディレクトリでminttyを開くショートカット

Winのショートカットを作成したら、作業フォルダー(S):を指定するのが肝。

リンク先:
`C:\cygwin64\bin\mintty.exe /bin/env CHERE_INVOKING=1 /bin/bash -l`

作業フォルダー:
`D:\workspace`

### tmuxinatorを使う

`ruby`はWin用のbinを使わず、ビルドして入れるほうが正常に動くっぽい。

`./configure`  
`make`  
`make install`  

`ruby`の正しいバージョンが入ったら  
`gem install tmuxinator`

```
ERROR:  While executing gem ... (Gem::Exception)
Unable to require openssl, install OpenSSL and rebuild ruby (preferred) or use non-HTTPS sources
```

この例外が出たら、ソースを`https://`でなく`http://`に変えればおｋ。  
`gem source --add <ソース>`でもまた別のエラーが出て面倒な場合は、`~/.gemrc`に直接ソースを記述する。


### chereでmintty起動したときのちっちゃいメッセージを消す

これ:
`Starting /bin/bash.exe`

https://superuser.com/questions/729424/remove-starting-bin-bash-exe-on-cygwin-chere

`/bin/xhere`の`echo`している行をコメントアウトするだけ。

### Windowsのbinは使わない

cygwinディレクトリの`bin`だけパスに設定。

`export PATH=/cygdrive/c/cygwin64/bin`  
`export PATH=$PATH:/cygdrive/c/cygwin64/usr/local/bin`  

`node`と`npm`は`cygwin`ではサポート外らしい?ので（ビルドも）Win用のバイナリを入れてパスを通す。
