# dotfiles

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

この例外が出たら、ソースを`https://`でなく`http://`に変えればおｋ。
`gem source --add <ソース>`でもまた別のエラーが出て面倒な場合は、`~/.gemrc`に直接ソースを記述する。

```
ERROR:  While executing gem ... (Gem::Exception)
Unable to require openssl, install OpenSSL and rebuild ruby (preferred) or use non-HTTPS sources
```

### chereでmintty起動したときのちっちゃいメッセージを消す

これ
`Starting /bin/bash.exe`

https://superuser.com/questions/729424/remove-starting-bin-bash-exe-on-cygwin-chere

### Windowsのbinは使わない

cygwinディレクトリの`bin`だけパスに設定。

export PATH=/cygdrive/c/cygwin64/bin
export PATH=$PATH:/cygdrive/c/cygwin64/usr/local/bin
