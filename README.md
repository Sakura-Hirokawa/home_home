# ほめホメ

## サイト概要
　その日達成したいことや頑張りたいことなどの目標を共有しあい、達成できたらユーザー同士で褒め合うことのできるECサイト。ユーザーは目標を3つ投稿し、達成できたらチェックマークを行う。投稿にチェックマークがついているユーザーを見つけた場合は、いいねやコメントをすることでユーザー同士で褒め合う。また、カレンダー機能を持ちスケジュール管理もできるため、カレンダーを見ながら目標を考えることでより明確な目標を立てることができる。

### サイトテーマ
ユーザー機能を持ち、ユーザーのその日の目標を投稿し、コメントやいいね機能を用いて気軽に褒められることのできるサイト。

### テーマを選んだ理由
　自分がその日に何をして何を頑張ったのかを記録したいと考え、その日に達成したことを3つ書くリスト用紙を自分で作成して記録し始めた。実行できた項目にチェックをすることで達成感を感じ、自分のことを褒められるようになった。
　この経験から、作成したリスト用紙を参考にして、自分の日々の生活を褒める・他者に褒められることで次の日を頑張るきっかけにつながるようなECサイトを開発しようと思い至った。

### ターゲットユーザー
* 20代・30代の日記を書かないユーザー（主に女性）
* 一人暮らしで褒めてくれる相手が近くにいないユーザー

### 主な利用シーン
* 就寝前に1日を振り返る時
* 通勤電車の中でその日のスケジュールを確認したい時
* 些細なことでも褒められたい時

## 設計書

### アプリケーション詳細設計書
<img width="430" alt="スクリーンショット 2021-06-28 21 24 11" src="https://user-images.githubusercontent.com/80041199/123636769-3605bf00-d858-11eb-806d-1e8f116f21ee.png">
<img width="432" alt="スクリーンショット 2021-06-28 21 24 16" src="https://user-images.githubusercontent.com/80041199/123636511-ecb56f80-d857-11eb-8ed2-57b2af7e8c14.png">

### ER図
<img width="878" alt="スクリーンショット 2021-06-28 22 14 40" src="https://user-images.githubusercontent.com/80041199/123642576-681a1f80-d85e-11eb-8778-9b1a20b8353f.png">
<img width="878" alt="スクリーンショット 2021-06-28 22 14 31" src="https://user-images.githubusercontent.com/80041199/123642634-7c5e1c80-d85e-11eb-827e-c079ad5653f9.png">

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1pU9hhK1-mNsjeTmnPl-dEk5FnWYqaGQ2dCFJh5ppjhY/edit?usp=sharing

## ログインユーザ
メールアドレス：test@test.com

パスワード:test2021

## 管理者用アカウント
メールアドレス：admin@admin.com

パスワード：admin1111

管理者用ログインURL： /admin/sign_in

## 使用方法
```
$ git clone git@github.com:Sakura-Hirokawa/home_home.git
$ bundle install
$ rails db:seed
$ rails s
```

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
