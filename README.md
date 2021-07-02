# ほめホメ

## サイト概要
　その日達成したいことや頑張りたいことなどの目標を共有しあい、達成できたらユーザ同士で褒め合うことのできるECサイト。ユーザは目標を3つ投稿し、達成できたら達成ステータスの更新を行う。達成ステータスが「実行中」から「達成」に更新されたユーザを見つけた場合は、いいねやコメントをすることでユーザ同士で褒め合う。また、カレンダー機能を持ちスケジュール管理もできるため、カレンダーを見ながら目標を考えることでより明確な目標を立てることができる。

### サイトテーマ
ユーザ機能を持ち、その日の目標や達成したいことを投稿し、コメント機能やいいね機能を用いて気軽に褒められることのできるサイト。

### テーマを選んだ理由
　自分がその日に何をして何を頑張ったのかを記録したいと考え、その日に達成したことを3つ書くリスト用紙を自分で作成して記録し始めた。達成したことを書くことで達成感や充実感を感じ、自分のことを褒められるようになった。また、次の日の目標を考えることによって、１日を大事に過ごそうと思えた。  この経験から、作成したリスト用紙を参考にして、自分の日々の生活を褒める・他者に褒められることで次の日を頑張るきっかけにつながるようなECサイトを開発しようと思い至った。

### ターゲットユーザ
* 20代・30代の日記を書かないユーザー（主に女性）
* 一人暮らしで褒めてくれる相手が近くにいないユーザ

### 主な利用シーン
* 就寝前に1日を振り返るとき
* 通勤電車の中でその日のスケジュールを確認したいとき
* 些細なことでも褒められたいとき

## 設計書

### 機能一覧
<img width="428" alt="スクリーンショット 2021-07-01 22 34 10" src="https://user-images.githubusercontent.com/80041199/124133236-97c66300-dabc-11eb-87df-e06e712dcbea.png">

### アプリケーション詳細設計書
<img width="430" alt="スクリーンショット 2021-06-28 21 24 11" src="https://user-images.githubusercontent.com/80041199/123636769-3605bf00-d858-11eb-806d-1e8f116f21ee.png">
<img width="432" alt="スクリーンショット 2021-06-28 21 24 16" src="https://user-images.githubusercontent.com/80041199/123636511-ecb56f80-d857-11eb-8ed2-57b2af7e8c14.png">

### ER図
<img width="876" alt="スクリーンショット 2021-07-02 20 04 33" src="https://user-images.githubusercontent.com/80041199/124265557-cd2c8880-db70-11eb-8372-f5386fc84efa.png">

### UIFlows
<img width="878" alt="スクリーンショット 2021-06-28 22 14 40" src="https://user-images.githubusercontent.com/80041199/123642576-681a1f80-d85e-11eb-8778-9b1a20b8353f.png">
<img width="878" alt="スクリーンショット 2021-06-28 22 14 31" src="https://user-images.githubusercontent.com/80041199/123642634-7c5e1c80-d85e-11eb-827e-c079ad5653f9.png">

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1pU9hhK1-mNsjeTmnPl-dEk5FnWYqaGQ2dCFJh5ppjhY/edit?usp=sharing

## ログインユーザ
メールアドレス：test@test.com

パスワード：test2021

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

## 使用素材
- O-DAN(https://o-dan.net/ja/)
- Canva(https://www.canva.com/)
- FREE LINE DESIGN(http://free-line-design.com/)