octopress-posted-by
===================

エントリごとに設定された著者情報をサイドバーに表示する機能です。
複数人で一つの GitHub Pages にエントリを投稿する際に利用すると便利です。

Features
--------

* 著者の Google+ / GitHub / Twitter / Facebook へのリンクを自動的に設定することができます。
* 著者のプロフィール画像として、Google+ のユーザアイコンを表示することができます。
* トップページやカテゴリ別ページなどの一覧表示では、著者情報を表示しません。

Installation
------------

``source/`` ディレクトリの内容と ``sass/`` ディレクトリに格納されているファイルを、それぞれのディレクトリ構造を保ちつつ、お使いの Octopress 環境にコピーすれば、インストールは完了します。

Usage
-----

まず、お使いの ``_config.yml`` ファイルの設定項目、 ``default_asides`` に ``custom/asides/posted_by.html`` を追記します。
Google+ のプロフィール画像を表示させる場合は、加えて Google+ API の呼び出しを有効化した API Key を以下のように追記します。

    # Posted by plugin
    posted_by:
      google_api_key: AIzaSyAgtwuTnGLddfsqsSrBHrGDuX5c95DEbwI

続いて、 ``source/_posts/`` ディレクトリの下の各エントリに、著者情報を記述します。
記述方法は以下の例を参考にしてください。

    ---
    layout: post
    title: エントリのタイトル
    date: 2013-12-09 12:34
    comments: true
    author: 著者名
    googleplus_user: (Google+ のユーザ ID)
    github_user: (GitHub のユーザ ID)
    twitter_user: (Twitter のスクリーン名)
    facebook_user: (Facebook のユーザ ID)
    ----
    エントリ本文...

* ``author`` に設定された著者名が、サイドバーの Posted by 欄に表示されます。
* ``googleplus_user`` には、Google+ の数値で表現されたユーザ ID を指定します。設定は任意です。
* ``github_user`` には、GitHub でのユーザ ID (ユーザページを表示したときの、 ``https://github.com/`` より後の文字列) を指定します。設定は任意です。
* ``twitter_user`` には、Twitter でのスクリーン名 (@ を取り除いた表記) を指定します。設定は任意です。
* ``facebook_user`` には、Facebook のユーザ ID (ユーザページを表示したときの、 ``https://facebook.com/`` より後の文字列) を指定します。設定は任意です。

License
-------

MIT License のもとで公開しています。詳しくは LICENSE.txt をご覧ください。
