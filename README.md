# PEAR_Experience3_Package
PEAR_Experience3_Package

## Workshop demo cleanup

Run `.\clean-workshop-demos.ps1` from anywhere inside this Git repository to remove untracked contents from the workshop demo directories using `git clean -f`. The listed directories themselves are preserved.

Preview the files that would be removed without deleting them:

```powershell
.\clean-workshop-demos.ps1 -WhatIf
```

The script is limited to `falling_block_puzzle`, `webpage_demo`, `research_assistant_demo`, `chatbot_on_AIPC`, and `speech_recognition_on_AIPC`. Git-tracked files and ignored files are not removed.
