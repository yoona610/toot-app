# TOOT
**すべての作業療法士が、より良いリハビリテーションを対象者に提供するため、自助具の材料や作り方を手軽に情報検索・共有できるサービスです。**

URL: https://tootapp.net

【管理者アカウント】
   メールアドレス： toot@toot.com
   パスワード： toot1234

 ※別途「ゲストログイン機能」（ワンクリックでログインが可能な機能）も実装していますので、ぜひそちらもご利用ください。


## サイト概要
**作業療法士に向けて、手作りの自助具を検索・投稿・共有できるサイト。

 投稿を検索、投稿、ランキング表示できる
 コメントや"いいね"をしたり、気になる投稿の保存（ブックマーク）、通知の確認ができる

実装機能の詳細は、[機能一覧](#機能一覧)をご確認ください。

### ◆サイトテーマ
**To Occupational Therapist**
### ◆テーマを選んだ理由
『より良いリハビリテーションを対象者に提供しようと努力する作業療法士(OT)を応援する』
これが TOOT に込めた想いです。
既製品の自助具では、対象者の個別性に対応できないこともあります。このような場合、OT は様々なアイデアを出し、手作りでオーダーメイドの自助具を作成します。
しかし、それらに関する情報は少なく、OT は作りたいもののイメージから、ホームセンターや 100 円均一を巡り、使えそうな材料を買って、作っては、上手くいかず失敗することも多々ありました。
そこで、toot は、若手の OT に向けて、検索のハードルを下げる・気軽に情報を得られる。またベテランの OT に向けて、自らの知見を共有できる。様々な世代が、交流できるコミュニティサイトにしたいと思っています。

### ◆ターゲットユーザー
 様々な情報を得たい若手の作業療法士
 自らの知見を発表・共有したいベテランの作業療法士


## 工夫・意識したポイント
**1. 徹底的なユーザー目線**
作業療法士の課題を解決するためのサービス作りであることを常に意識し、単に「見せる」ための作品ではなく、困っている人が「使い続けたい」と思えるサービスとなるよう、直感的に使用できる機能やレイアウトを考え抜き、作成しました。例として、2つの機能をご紹介します：

   **投稿フォームにおける入力欄の追加・削除機能**
     投稿を書き上げる中で、行の削除や追加が必要となるユーザーは多いのではないか？と考え、cocoonで実装しました。

   **下書き保存機能**
     ユーザーにとっての利便性を考慮し下書き保存機能を実装しました。

   **通知機能**
     ユーザー間、ユーザーと管理者間の通知を実装し、ユーザービリティを考慮し、フォローやコメントに加え、お問い合わせのステータス変更を実装しました。


## 設計書
### ◆ER図
https://drive.google.com/file/d/16M2WD9tfr2b0i0PoChAFNipfXZr4URZd/view?usp=sharing

### ◆テーブル定義書
https://docs.google.com/spreadsheets/d/1C3rz6ptc5tMSv_yz4akpZeY4Ek7novYP/edit?usp=sharing&ouid=116209756082326194131&rtpof=true&sd=true

## 機能一覧
### ◆顧客側の機能
| 機能 | 非ログイン時利用可否 | 無料会員利用可否 |
|  | :: |:: |
| 無料会員登録  | ○ | × |
| ログイン | ○ | ○ |
| ログアウト | × | ○ |
| 退会 | × | ○ |
| 投稿 | × | ○ |
| 投稿編集 | × | ○ |
| 投稿削除 | × | ○ |
| 下書き | × | ○ |
| ブックマーク（Ajax) | × | ○ |
| 検索 | ○ | ○ |
| ランキング表示 | × | ○ |
| いいね（Ajax) | × | ○ |
| コメント投稿 （Ajax)| × | ○ |
| コメント削除 （Ajax)| × | ○ |
| 会員詳細表示 | ○ | ○ |
| 会員情報編集 | × | ○ |
| フォロー（Ajax) | × | ○ |
| チャット送信（Ajax) | × | ○ |
| 通知 | × | ○ |

### ◆管理者側の機能
| 機能 | 非ログイン時利用可否 |
|  |
| ログイン | ○ |
| ログアウト | × |
|投稿一覧表示 | × |
|投稿詳細表示 | × |
|投稿削除 | × |
|会員一覧表示 | × |
|会員詳細表示 | × |
|会員退会 | × |
|問い合わせ一覧表示（チャット） | × |
|問い合わせ詳細表示（チャット） | × |
|チャット送信 | × |
| 通知 | × | ○ |

### ◆その他導入技術等
 バッチ処理：閲覧履歴の定時削除
 レスポンシブ（Bootstrap)
 自動デプロイ（GitHub Actions)

#### 使用ライブラリ
 devise（ログイン認証）
 refile, mini_magick（画像投稿）
 RuboCop（静的コード解析）
 kaminari（ページネーション）
 cocoon (フォームの追加削除)
 whenever（バッチ処理）
 bullet（N+1問題）
 dotenvrails（環境変数）
 prybyebug（デバッグ）


## 開発環境
 OS：Linux(CentOS)
 言語：HTML,CSS,JavaScript,Ruby,SQL
 フレームワーク：Ruby on Rails, Bootstrap
 JSライブラリ：jQuery
 IDE：Cloud9


## 使用素材
**【画像素材】**
 ODAN (<https://odan.net/ja/>)