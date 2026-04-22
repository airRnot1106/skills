---
name: frontend-structure
description: >
  明名の思想に基づくフロントエンドのディレクトリ構成設計と BCD Design によるコンポーネント命名のガイドライン。
  ディレクトリ構成の設計・リファクタリング、コンポーネントの命名・配置、新規フロントエンドプロジェクトのセットアップ、
  ファイルやコンポーネントの配置判断時にトリガー。package by feature、ドメイン駆動のディレクトリ設計、
  BCD Design、明名、後方一致に関する質問や作業で使用する。
---

# Frontend Structure

明名の思想を package by feature に反映させたフロントエンドディレクトリ構成ガイドライン。

## src/ 直下の構成

| ディレクトリ  | 役割                                                  | 備考              |
| ------------- | ----------------------------------------------------- | ----------------- |
| `features/`   | ドメイン固有のコード                                  | 最優先の配置先    |
| `components/` | ドメインに属さないプリミティブなコンポーネント        |                   |
| `hooks/`      | ドメインに属さない汎用的な React hook                 |                   |
| `lib/`        | 特定ライブラリの設定（prisma client, better-auth 等） | `utils/` より優先 |
| `utils/`      | 汎用処理                                              | 最終手段          |

`app/` は薄いルーティング層。layout と page のみ配置し、コンポーネント定義は行わない。複数ドメインにまたがるページは `page.tsx` で各 `features/` から import して組み合わせる。

## features/ の内部構造

| ファイル/ディレクトリ | 役割                                           | 特性                 |
| --------------------- | ---------------------------------------------- | -------------------- |
| `models.ts`           | ドメインモデル、value object、ドメインロジック | フレームワーク非依存 |
| `api/`                | fetch ラッパー                                 |                      |
| `actions/`            | Server Actions                                 |                      |
| `hooks/`              | React API を伴うロジック                       | React 依存           |
| `components/`         | UI 表現                                        |                      |

**原則: ドメインロジックはコンポーネント内に定義しない。** `models` はフレームワーク非依存であり、単体テストが容易になる。

## 後方一致によるネスト

ディレクトリのネスト判断は**後方一致**で行う。

**後方一致 → ネストする:**

`normal-user` と `premium-user` → `user/{normal-user, premium-user}`

**前方一致のみ → ネストしない:**

`user-name` と `user-detail` → 同階層に並べる

### `_base` による対称性

修飾子のないドメインもバリアントと並存する場合、`_base` ディレクトリを挟んで対称性を保つ:

```
user/
├── _base/          # 修飾子のない user
├── normal-user/
└── premium-user/
```

`_base` は固定名。

## 依存ルール

名前の修飾構造が依存方向を決定する。依存は常に **具体 → 抽象** の一方向:

- `event-participating-broadcaster` → `broadcaster` に依存可能（逆は不可）
- `src/components/` → `features/` を参照不可。Domain を持った時点で `features/` に移動すべき
- 明名が正しければ循環参照は自然に発生しない

**依存は後方一致（IS-A）ベース。前方修飾は依存を生まない。**

後方一致によるネストと同じロジックで依存先を決定する。名前の後方部分がその entity の IS-A を表すため、依存先は後方部分が示す抽象ドメインになる。前方修飾はコンテキストの説明であり IS-A ではないため依存しない。

- `event-schedule` の後方は `-schedule`（IS-A: schedule）→ `event` への依存は**発生しない**
- `event-participating-broadcaster` の後方は `-broadcaster`（IS-A: broadcaster）→ `broadcaster` に依存可能

## 明名の原則

すべてのルールの哲学的基盤。

**命名とは、コンテキストが持つ概念を明らかにし、一定の順序で並べること。** 人間が名前を創るのではなく、もともと存在する内容や性質を発見する。

- **日本語で概念を捉え、その語順を英語に反映する**
- 放送者 → `Broadcaster`
- イベントに参加している放送者 → `EventParticipatingBroadcaster`
- 企画チームが開催しているイベントに参加している放送者 → `PlanningEventParticipatingBroadcaster`

## BCD Design

コンポーネントの命名には BCD Design（Domain-Case-Base）を使用する。

詳細は [references/bcd-design.md](references/bcd-design.md) を参照。

## ディレクトリ構成例

具体的な構成例は [references/directory-examples.md](references/directory-examples.md) を参照。
