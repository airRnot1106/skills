# BCD Design

コンポーネントの分類・命名における明名のフレームワーク。

## 3つの軸

- **Domain** — 何の / 何を（ドメインコンテキスト）
- **Case** — どうする（状況・アクション）
- **Base** — UI型（ボタン、カード、セクションなど）

## 命名規則

```
(1 or 2) 何の / 何を  (3) どうする  (4) UI
         Domain            Case         Base
```

- **Base は必須**
- **Case は省略可**（状況を示す必要がない場合）
- コンポーネント名は `Domain-Case-Base` の順序

## Domain の有無による配置

| Domain                       | 配置先                   |
| ---------------------------- | ------------------------ |
| なし（Case + Base のみ）     | `src/components/`        |
| あり（特定ドメインに属する） | `features/*/components/` |

## 命名例

| 日本語                               | コンポーネント名                                 | Domain                                | Case   | Base        |
| ------------------------------------ | ------------------------------------------------ | ------------------------------------- | ------ | ----------- |
| 追加ボタン                           | AddButton                                        | —                                     | Add    | Button      |
| サインインボタン                     | SigninButton                                     | —                                     | Signin | Button      |
| 記事投稿フォーム                     | ArticlePostForm                                  | Article                               | Post   | Form        |
| コメント編集フォーム                 | CommentEditForm                                  | Comment                               | Edit   | Form        |
| 放送者一覧セクション                 | BroadcasterListSection                           | Broadcaster                           | —      | ListSection |
| 企画イベント参加放送者一覧セクション | PlanningEventParticipatingBroadcasterListSection | PlanningEventParticipatingBroadcaster | —      | ListSection |

## 日本語からの変換

日本語の語順をそのまま英語に反映する:

- 放送者 → `Broadcaster`
- イベントに参加している放送者 → `EventParticipatingBroadcaster`
- 企画チームが開催しているイベントに参加している放送者 → `PlanningEventParticipatingBroadcaster`

## Base 単語帳

### 抽象的なUI

| UI名    | 意味     | 説明                                                            |
| ------- | -------- | --------------------------------------------------------------- |
| Area    | エリア   | コンポーネント内の区画や領域。濫用しないほうが良い              |
| Bar     | バー     | 棒状のスペースでまとまりを表現。ゲージやメーターの値にも使用可  |
| Board   | ボード   | Panel と似ているが、掲示するものに使用されることが多い          |
| Box     | ボックス | 四角い領域に対して使用されることが多い                          |
| Frame   | フレーム | 枠の概念                                                        |
| Group   | グループ | 同種の UI を集約する概念。RadioGroup など他 UI 名と合わせて使用 |
| Wrapper | ラッパー | 対象を包括する概念。濫用しないほうが良い                        |

### 文字列を表現するUI

| UI名    | 意味     | 説明                                                             |
| ------- | -------- | ---------------------------------------------------------------- |
| Heading | 見出し   |                                                                  |
| Label   | ラベル   | HTML の label 相当。Indicator のステータス表現の別名としても使用 |
| Link    | リンク   |                                                                  |
| Text    | テキスト |                                                                  |

### 値を表現するUI

| UI名      | 意味         | 説明                                                  |
| --------- | ------------ | ----------------------------------------------------- |
| Indicator | インジケータ | 状態を表示する表示器を表現する UI                     |
| Number    | 数値         | 数値を表現する UI                                     |
| Message   | メッセージ   | 意図を表現する UI。type で info/warn/error 表現に対応 |
| Time      | 時刻         | 時刻を表現する UI                                     |

### 視覚的なUI

| UI名   | 意味     | 説明                                                 |
| ------ | -------- | ---------------------------------------------------- |
| Banner | バナー   | 画像であることが多いが、必ずしも画像である必要はない |
| Icon   | アイコン |                                                      |
| Image  | 画像     |                                                      |

### 入力に関するUI

| UI名         | 意味             | 説明                                                               |
| ------------ | ---------------- | ------------------------------------------------------------------ |
| Button       | ボタン           |                                                                    |
| CheckBox     | チェックボックス | Switch と似ているが反映するボタンと一緒に使用するのが正しい        |
| ComboBox     | コンボボックス   |                                                                    |
| Form         | フォーム         |                                                                    |
| ListBox      | リストボックス   | 選択機能を有したメニューを表現する UI                              |
| Palette      | パレット         | 色の設定などで使用する UI                                          |
| Radio        | ラジオボタン     | 厳格には RadioButton だが、一般的に Radio で略しても良い           |
| SeekBar      | シークバー       |                                                                    |
| SelectBox    | セレクトボックス |                                                                    |
| Slider       | スライダー       |                                                                    |
| Switch       | スイッチ         | 即時反映される ON/OFF を切り替える UI                              |
| TextArea     | テキストエリア   | 複数行のテキストを入力する UI                                      |
| TextBox      | テキストボックス | 単一行のテキストを入力する UI                                      |
| ToggleButton | トグルボタン     | 押下する度に ON/OFF が切り替わるボタン。Toolbar の寄せ選択等で使用 |
| Thumb        | つまみ           | Slider の掴む部分などに使用される UI                               |
| Track        | トラック         | Slider の軌道(溝)の部分などに使用される UI                         |

### 輪郭を表現するUI

| UI名    | 意味         | 説明                                                              |
| ------- | ------------ | ----------------------------------------------------------------- |
| Footer  | フッター     | 本体の情報に対する付加的な情報をまとめる UI                       |
| Header  | ヘッダー     | 本体の情報に対する表題や概要をまとめる UI                         |
| Layer   | レイヤー     | 層を表現する UI                                                   |
| Layout  | レイアウト   | 配置を表現する UI                                                 |
| Page    | ページ       | ページを表現する UI                                               |
| Pane    | ペイン       | 画面の一部を区切って表示する領域 UI                               |
| Panel   | パネル       | 他から区別された領域を形成する UI。浮かせたり、はめ込んだりできる |
| Section | セクション   | 情報の自立したまとまりを表現する UI                               |
| Divider | ディバイダー | 仕切りを表現する UI。Separator でも良い                           |

### 特定の形式を表現するUI

| UI名            | 意味             | 説明                                |
| --------------- | ---------------- | ----------------------------------- |
| Breadcrumb      | パンくずリスト   | ユーザーの現在位置を視覚化する UI   |
| Card            | カード           | 主題に関する簡潔な情報をまとめた UI |
| Chip            | チップ           | 入力、属性、アクションを表す UI     |
| DescriptionList | 説明リスト       | 一連の用語と説明を一覧にした UI     |
| Field           | フィールド       | Label と入力要素のセットの単位の UI |
| Fieldset        | フィールドセット | 入力要素をグループ化する UI         |
| Item            | 項目             | List や Menu の項目を表現する UI    |
| List            | リスト           | 配列を一覧する UI                   |
| Menu            | メニュー         | 項目で選択肢を提供する UI           |
| Table           | テーブル         | 表組み形式の UI                     |

### フィードバックに使用されるUI

| UI名               | 意味         | 説明                                |
| ------------------ | ------------ | ----------------------------------- |
| Balloon            | バルーン     |                                     |
| Dialog             | ダイアログ   | 正式名称は DialogBox                |
| NotificationBanner | 通知バナー   | アプリなどでよく使用される対話的 UI |
| Snackbar           | スナックバー |                                     |
| Tooltip            | ツールチップ |                                     |

### 汎用的な機能を持つUI

| UI名       | 意味             | 説明                                              |
| ---------- | ---------------- | ------------------------------------------------- |
| Accordion  | アコーディオン   | 項目を展開して表示できる機能を有する UI           |
| DataGrid   | データグリッド   | 表形式で大量のデータを表示する機能を有する UI     |
| Dock       | ドック           | Launcher とほぼ同等の機能を有する UI              |
| Launcher   | ランチャー       | 起動を補助する機能を有する UI                     |
| Pagination | ページネーション | ページ送りを行う機能を有する UI                   |
| Tabs       | タブズ           | Tab で TabPanel を切り替える機能を有する UI       |
| Ticker     | ティッカー       | 一定時間で表示が切り替わる機能を有する UI         |
| Toolbar    | ツールバー       | Roving TabIndex の機能を有し、道具が並べられた UI |

### 現実世界に存在するUI

| UI名       | 意味           | 説明                                                              |
| ---------- | -------------- | ----------------------------------------------------------------- |
| Billboard  | ビルボード     | 主に広告用の掲示板、屋外の巨大な看板を表す UI                     |
| Controller | コントローラー | 操作するための UI をまとめた UI                                   |
| Display    | ディスプレイ   | 映像信号を表示する装置または何かを展示・陳列するスペースを表す UI |
| Monitor    | モニター       | Display と同じだが、監視目的という点が異なる                      |
| Player     | プレーヤー     | 媒体の再生装置。Controller や Screen を持つ UI                    |
| Reader     | リーダー       | 情報を読むための UI                                               |
| Renderer   | レンダラー     | 描画する装置を表す UI                                             |
| Screen     | スクリーン     | 映像を映し出す平面を表す UI                                       |
| Tool       | ツール         | ある目的を達成するために必要な機能や情報を集約した UI             |
| Viewer     | ビューア       | 表示、閲覧するための装置を表す UI                                 |

## @see

- https://zenn.dev/misuken/articles/93f6f47eb05b94
- https://zenn.dev/misuken/articles/6bfadc96f1fecb
- https://zenn.dev/misuken/articles/203b9dd3afbf1c
- https://qiita.com/misuken/items/19f9f603ab165e228fe1
- Case/Base 単語帳: https://docs.google.com/spreadsheets/d/e/2PACX-1vTZRJMEKmag7-yCsptuzNmhivtTjekMsU-4Yantfw9enXYmLzW46XIqPedMIPZGFBV8gm0SXDPqckgP/pubhtml
