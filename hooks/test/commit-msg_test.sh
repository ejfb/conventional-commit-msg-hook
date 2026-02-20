#!/bin/bash
# run with shunit2 commit-msg_test.sh
# shunit2 must be installed

testBasicCommitMessage() {
    cat > "$TEST_MSG_FILE" << EOL
feat
login api
Add user authentication
Some description about the change
Implements login flow
123
EOL

    ../commit-msg "$TEST_MSG_FILE"

    expected="feat(login-api): Add user authentication

Some description about the change
Implements login flow

refs: #123"

    actual=$(cat "$TEST_MSG_FILE")
    assertEquals "$expected" "$actual"
}

testNoRefCommitMessage() {
    cat > "$TEST_MSG_FILE" << EOL
feat
login api
Add user authentication
Some description about the change
Implements login flow
EOL

    ../commit-msg "$TEST_MSG_FILE"

    expected="feat(login-api): Add user authentication

Some description about the change
Implements login flow

refs: none"

    actual=$(cat "$TEST_MSG_FILE")
    assertEquals "$expected" "$actual"
}

testManualNoneRef() {
    cat > "$TEST_MSG_FILE" << EOL
refactor
readme
fixes typo
none
EOL

    ../commit-msg "$TEST_MSG_FILE"

    expected="refactor(readme): fixes typo

refs: none"

    actual=$(cat "$TEST_MSG_FILE")
    assertEquals "$expected" "$actual"
}

testPreformattedCommitMessage() {
    cat > "$TEST_MSG_FILE" << EOL
feat(login-api): Add user authentication

Some description about the change
Implements login flow

refs: none
EOL

    ../commit-msg "$TEST_MSG_FILE"

    expected="feat(login-api): Add user authentication

Some description about the change
Implements login flow

refs: none"

    actual=$(cat "$TEST_MSG_FILE")
    assertEquals "$expected" "$actual"
}

testPreformattedRefCommitMessage() {
    cat > "$TEST_MSG_FILE" << EOL
feat(login-api): Add user authentication

Some description about the change
Implements login flow

refs: none
EOL

    ../commit-msg "$TEST_MSG_FILE"

    expected="feat(login-api): Add user authentication

Some description about the change
Implements login flow

refs: none"

    actual=$(cat "$TEST_MSG_FILE")
    assertEquals "$expected" "$actual"
}

testMergeCommitMessage() {
    cat > "$TEST_MSG_FILE" << EOL
Merge remote-tracking branch 'origin/main' into feature-branch
EOL

    ../commit-msg "$TEST_MSG_FILE"

    expected="Merge remote-tracking branch 'origin/main' into feature-branch"

    actual=$(cat "$TEST_MSG_FILE")
    assertEquals "$expected" "$actual"
}

testMinimalCommitMessage() {
    cat > "$TEST_MSG_FILE" << EOL
feat(login-api): Add user authentication
EOL

    ../commit-msg "$TEST_MSG_FILE"

    expected="feat(login-api): Add user authentication

refs: none"

    actual=$(cat "$TEST_MSG_FILE")
    assertEquals "$expected" "$actual"
}


setUp() {
    TEST_MSG_FILE="test_commit_msg.txt"
}

tearDown() {
    rm -f "$TEST_MSG_FILE"
}