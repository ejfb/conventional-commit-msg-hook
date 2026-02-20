# conventional-commit-msg-hook

A `commit-msg` git hook that formats a structured multi-line input into a [Conventional Commits](https://www.conventionalcommits.org/) compliant message.

## Input format

Write your commit message with each field on its own line:

```
<type>
<scope>
<title>
<body (optional, multiple lines)>
<issue ref or "none" (optional)>
```

Example:

```
feat
login api
add user authentication
implements the login flow
42
```

Produces:

```
feat(login-api): add user authentication

implements the login flow

refs: #42
```

- Scope is lowercased and spaces are replaced with hyphens.
- If the last line is a number it becomes `refs: <prefix><n>`, otherwise `refs: none`. The prefix defaults to `#` for Notion style refs and can be changed at the top of the hook (and test) file.
- If the message is already conventionally formatted (e.g. `feat(...):`) or is a merge commit, it passes through unchanged.

## Installation

Copy or symlink `hooks/commit-msg` into your repo's `.git/hooks/` directory:

```sh
# copy
cp hooks/commit-msg /path/to/your/repo/.git/hooks/commit-msg

# symlink (requires Developer Mode on Windows or admin)
ln -s "$(pwd)/hooks/commit-msg" /path/to/your/repo/.git/hooks/commit-msg
```

Or point the repo at this hooks directory directly:

```sh
git -C /path/to/your/repo config core.hooksPath /path/to/conventional-commit-msg-hook/hooks
```

## Configuration

Edit `REF_PREFIX` at the top of `hooks/commit-msg` to match your issue tracker:

```sh
REF_PREFIX="#"      # GitHub (default)
REF_PREFIX="PROJ-"  # Jira
```

Update the same variable at the top of `hooks/test/commit-msg_test.sh` to keep tests in sync.

## Testing

Tests use [shunit2](https://github.com/kward/shunit2). Install it, then run:

```sh
cd hooks/test
shunit2 commit-msg_test.sh
```
