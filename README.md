# PEAR_Experience3_Package
PEAR_Experience3_Package

## Workshop demo cleanup

Run `.\clean-workshop-demos.ps1` from anywhere inside this Git repository to remove untracked and ignored contents from the workshop demo directories using `git clean -fdx`. The listed directories themselves are preserved.

The script writes timestamped progress messages for each directory and reports completion or errors.

Preview the files that would be removed without deleting them:

```powershell
.\clean-workshop-demos.ps1 -WhatIf
```

The script is limited to `falling_block_puzzle`, `webpage_demo`, `research_assistant_demo`, `chatbot_on_AIPC`, and `speech_recognition_on_AIPC`. Git-tracked files and files outside those directories are not removed.

## Workshop repository cloning

Run `.\clone-workshop-repos.ps1` from anywhere inside this Git repository to clone the configured workshop repositories into their matching folders. It skips folders that already contain files and reports progress with timestamps. `falling_block_puzzle` is skipped until a repository URL is configured; `travel_agent_demo` is cloned into its own folder.
