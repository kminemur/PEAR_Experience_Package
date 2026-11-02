# PEAR Experience Package

## ワークショップデモのクリーンアップ

このGitリポジトリ内の任意の場所から `.\clean-workshop-demos.ps1` を実行すると、`git clean -fdx` を使ってワークショップデモ用ディレクトリ内の未追跡ファイルと無視対象ファイルを削除します。対象のディレクトリ自体は保持されます。

スクリプトは各ディレクトリの処理状況をタイムスタンプ付きで表示し、完了またはエラーを報告します。

削除せずに、削除対象のファイルを確認するには次のコマンドを実行します。

```powershell
.\clean-workshop-demos.ps1 -WhatIf
```

対象ディレクトリは `falling_block_puzzle_demo`、`webpage_demo`、`research_assistant_demo`、`chatbot_on_AIPC`、`speech_recognition_on_AIPC` に限定されています。Gitで追跡されているファイル、およびこれらのディレクトリ外のファイルは削除されません。

## ワークショップリポジトリのクローン

このGitリポジトリ内の任意の場所から `.\clone-workshop-repos.ps1` を実行すると、設定済みのワークショップリポジトリを対応するフォルダにクローンします。ファイルがすでに存在するフォルダはスキップし、処理状況をタイムスタンプ付きで表示します。`travel_agent_demo` は専用のフォルダにクローンされます。
