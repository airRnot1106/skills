# ディレクトリ構成例

## src/ 直下の全体構成

```
src/
├── components/           # ドメインに属さないプリミティブなコンポーネント
│   ├── button/
│   │   ├── _base/
│   │   ├── add-button/
│   │   ├── signin-button/
│   │   └── index.ts
│   ├── button-link/
│   └── card/
├── features/             # ドメイン固有のコード
│   └── user/
│       ├── _base/
│       │   └── components/
│       ├── normal-user/
│       │   ├── components/
│       │   └── models.ts
│       └── premium-user/
├── hooks/                # ドメインに属さない汎用的な hook
├── lib/                  # 特定ライブラリの設定（prisma client, better-auth 等）
└── utils/                # 汎用処理（最終手段）
```

## app/ の構成

```
app/
├── layout.tsx
├── page.tsx
├── users/
│   └── [id]/
│       └── page.tsx      # features/ からコンポーネントを import して組み合わせる
└── dashboard/
    └── page.tsx          # 複数の features/ から import して構成
```

- `app/` には layout と page のみ配置する
- コンポーネントの定義は行わない
- 複数ドメインにまたがるページは `page.tsx` で各 `features/` から import して組み合わせる

## features/ 内のドメイン構成

### 後方一致によるネスト

`normal-user` と `premium-user` は `-user` で後方一致するため `user/` にネスト:

```
features/
└── user/
    ├── _base/            # 修飾子のない user ドメイン
    ├── normal-user/
    └── premium-user/
```

### 前方一致はまとめない

`user-name` と `user-detail` は後方が異なるため同階層:

```
features/
├── user-name/
└── user-detail/
```

### ドメイン内部の構成

```
features/
└── user/
    └── _base/
        ├── components/   # UI 表現
        ├── hooks/        # React API を伴うロジック
        ├── api/          # fetch ラッパー
        ├── actions/      # Server Actions
        └── models.ts     # ドメインモデル、value object、ドメインロジック
```

## components/ 内の後方一致

`add-button` と `signin-button` は `-button` で後方一致 → `button/` にネスト:

```
components/
├── button/
│   ├── _base/            # 修飾子のない button
│   ├── add-button/
│   └── signin-button/
└── button-link/          # 後方が -link のため button/ とは別
```
