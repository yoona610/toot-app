# TOOT
**すべての作業療法士が、より良いリハビリテーションを対象者に提供するため、自助具の材料や作り方を手軽に情報検索・共有できるサービスです。**

URL: https://tootapp.net

【顧客アカウント】
   メールアドレス： toot@example.com
   パスワード： toot1234

【管理者アカウント】
   メールアドレス： toot-admin@example.com
   パスワード： toot1234

 ※別途「ゲストログイン機能」（ワンクリックでログインが可能な機能）も実装していますので、ぜひそちらもご利用ください。


## サイト概要
**作業療法士に向けて、手作りの自助具を検索・投稿・共有できるサイト。**

 投稿を検索、投稿、ランキング表示できる</br>
 コメントや"いいね"をしたり、気になる投稿の保存（ブックマーク）、通知の確認ができる

 実装機能の詳細は、[機能一覧](#機能一覧)をご確認ください。

### ◆サイトテーマ
**To Occupational Therapist**
### ◆テーマを選んだ理由
 『より良いリハビリテーションを対象者に提供しようと努力する作業療法士(OT)を応援する』</br>
 これが TOOT に込めた想いです。</br>
 既製品の自助具では、対象者の個別性に対応できないこともあります。</br>
 このような場合、OT は様々なアイデアを出し、手作りでオーダーメイドの自助具を作成します。</br>
 しかし、それらに関する情報は少なく、OT は作りたいもののイメージから、</br>
 ホームセンターや 100 円均一を巡り、使えそうな材料を買って、作っては、上手くいかず失敗することも多々ありました。</br>
 そこで、toot は、若手の OT に向けて、検索のハードルを下げる・気軽に情報を得られる。</br>
 またベテランの OT に向けて、自らの知見を共有できる。様々な世代が、交流できるコミュニティサイトにしたいと思っています。

### ◆ターゲットユーザー
 - 様々な情報を得たい若手の作業療法士
 - 自らの知見を発表・共有したいベテランの作業療法士


## 工夫・意識したポイント
**1. 徹底的なユーザー目線**
 作業療法士が抱える課題を解決するためのサービス作りであることを常に意識し、単に「見せる」ための作品ではなく、</br>
 困っている人が「使い続けたい」と思えるサービスとなるよう、直感的に使用できる機能やレイアウトを考え抜き、作成しました。

 例として、4つの機能をご紹介します。

   **投稿フォームにおける入力欄の追加・削除機能**
     投稿を書き上げる中で、行の削除や追加が必要となるユーザーは多いのではないか？と考え、</br>
　   cocoonとjQueryで実装しました。


   **下書き保存機能**
     内容は書き終えたが写真は後日撮って公開したい、といった状況は容易に発生し得るため、</br>
　   ユーザーにとっての利便性を考慮し下書き保存機能を実装しました。


   **通知機能(いいね、ブックマーク、コメント、お問い合わせチャット)**
     ユーザー間や管理者とのやり取りが円滑に行えるよう、通知機能を実装しました。


   **画像プレビュー機能**
     refileは新規投稿・投稿編集時に、デフォルトでは選択した画像が表示されないため、</br>
　   複数画像選択する際に使いづらいと感じたため、jQueryにて実装しました。


**2. レスポンスの向上**
 当初TOOTはトップページの画像の読み込みに最長15秒を要しており、ユーザーにとってストレスフルな状態でした。</br>
 そこで、レスポンスを向上できないかと改善に取り組み、refileの画像アップロード先をオブジェクトストレージ(S3)を利用することで、</br>
 結果的に7秒で表示できるようになりました。


## 設計書
### ◆ER図
![ER図](https://user-images.githubusercontent.com/83486228/133893688-88e94d3d-33b4-4737-917f-75380e2b40d8.jpg)

### ◆テーブル定義書
 https://docs.google.com/spreadsheets/d/1C3rz6ptc5tMSv_yz4akpZeY4Ek7novYP/edit?usp=sharing&ouid=116209756082326194131&rtpof=true&sd=true

### ◆インフラ構成図
![AWS構成図 (1)](https://user-images.githubusercontent.com/83486228/133893647-183d6fe5-9872-429d-8308-e9b2ab3449ad.jpg)


## 機能一覧
### ◆顧客側の機能
 | 機能 | 非ログイン時利用可否 |
 |:---|:---|
 | 会員登録  | ○ |
 | ログイン | ○ |
 | ログアウト | × |
 | 退会 | × |
 | 新規投稿 | × |
 | 投稿編集 | × |
 | 投稿削除 | × |
 | 投稿下書き | × |
 | 投稿閲覧履歴 | × |
 | 投稿検索 | ○ |
 | 新着投稿表示 | ○ |
 | 投稿詳細表示 | ○ |
 | ランキング表示 | × |
 | ブックマーク (Ajax) | × |
 | いいね (Ajax) | × |
 | コメント投稿 (Ajax) | × |
 | コメント削除 (Ajax) | × |
 | 星評価 (Ajax) | × |
 | 会員詳細表示 | ○ |
 | 会員情報編集 | × |
 | フォロー (Ajax) | × |
 | お問い合わせチャット送信 (Ajax) | × |
 | お問い合わせステータス更新 (Ajax) | × |
 | 通知 | × |


### ◆管理者側の機能
 | 機能 | 非ログイン時利用可否 |
 |:---|:---|
 | ログイン | ○ |
 | ログアウト | × |
 |投稿一覧表示 | × |
 |投稿詳細表示 | × |
 |投稿削除 | × |
 |カテゴリ一覧表示 | × |
 |カテゴリ追加 | × |
 |カテゴリ編集 | × |
 |カテゴリ削除 | × |
 |会員一覧表示 | × |
 |会員詳細表示 | × |
 |会員退会 | × |
 |問い合わせ一覧表示 | × |
 |問い合わせ詳細表示 | × |
 |チャット送信 (Ajax) | × |
 | 通知 | × |


### ◆その他導入技術等
 - バッチ処理：閲覧履歴・通知の定時削除
 - レスポンシブ(Bootstrap)
 - 自動デプロイ(GitHub Actions)
 - オブジェクトストレージ(S3)
 - 例外発生時の通知機能(CloudWatch)


#### 使用ライブラリ
 - ログイン認証(devise)
 - 画像アップロード(refile)
 - S3への画像アップロード(refile-s3)
 - ページネーション(kaminari)
 - ネストしたフォームの処理(cocoon)
 - 静的コード解析(Rubocop)
 - バッチ処理(whenever)
 - N+1問題(bullet)
 - パンくずリスト(gretel)
 - 環境変数(dotenv-rails)
 - デバッグ(pry-byebug)
 - 単体テスト(RSpec, FactoryBot, Faker)
 - 統合テスト(Capybara)
 - マイグレーションファイル集約(squasher)


## 開発環境
 - OS：Linux(CentOS)
 - 言語：HTML,CSS,JavaScript,Ruby,SQL
 - フレームワーク：Ruby on Rails, Bootstrap
 - JSライブラリ：jQuery
 - IDE：Cloud9


## 使用素材
**【画像素材】**
 - ODAN (<https://odan.net/ja/>)