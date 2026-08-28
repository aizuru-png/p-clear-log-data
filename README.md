# P-Clear Log 楽曲配信用データ

P-Clear Logがアプリ内更新で取得する楽曲データです。

## ファイル

- `manifest.json`: データ版、更新日、件数、ダウンロード先、SHA-256
- `songs.json`: Lv47〜50の譜面データ

## 更新するとき

1. `songs.json`を新しい内容に差し替える
2. `songs.json`のSHA-256を計算する
3. `manifest.json`の`dataVersion`を1増やす
4. `updatedAt`、`songCount`、`sha256`を更新する
5. `songs.json`を先にGitHubへ反映する
6. 最後に`manifest.json`を反映する

Windowsでは、このフォルダー内の`Update-Manifest.ps1`を実行すると、手順2〜4を自動で処理できます。

既存の`id`は変更しないでください。アプリは`id`を使ってクリア状態、BAD数、メモを引き継ぎます。
