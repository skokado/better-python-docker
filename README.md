マルチステージビルドを利用して軽量、セキュアなPython実行環境用コンテナイメージのサンプル

- 使用ライブラリ
    - django
    - django-auth-ldap

※django-auth-ldapの依存関係で必要となる`python-ldap`がインストール時にビルドを伴うため例として選定。

(超)参考: [仕事でPythonコンテナをデプロイする人向けのDockerfile (1): オールマイティ編 | フューチャー技術ブログ](https://future-architect.github.io/articles/20200513/)

```shell
$ docker build . -t awesome-django
```
