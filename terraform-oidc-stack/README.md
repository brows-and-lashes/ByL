This terraform stack is using github provider, if using, GitHub CLI it needs additional scope:

```
gh auth login --scopes user:email,read:user
```
