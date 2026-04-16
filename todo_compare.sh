#!/bin/bash

TEMPLATE="$1"
TARGET="$2"

if [[ -z "$TEMPLATE" || -z "$TARGET" ]]; then
    echo "Usage: $0 template.py target.py"
    exit 1
fi

if [[ ! -f "$TEMPLATE" || ! -f "$TARGET" ]]; then
    echo "Error: One of the files does not exist."
    exit 1
fi

# Function to strip TODO block contents
strip_todo_blocks() {
    awk '
    BEGIN { in_block=0 }
    /# TODO - BLOCK START/ {
        print "# TODO - BLOCK START"
        in_block=1
        next
    }
    /# TODO - BLOCK END/ {
        print "# TODO - BLOCK END"
        in_block=0
        next
    }
    {
        if (!in_block) {
            print $0
        }
    }
    ' "$1"
}

TMP1=$(mktemp)
TMP2=$(mktemp)

strip_todo_blocks "$TEMPLATE" > "$TMP1"
strip_todo_blocks "$TARGET" > "$TMP2"

echo -e "\n🔍 Comparing files (ignoring TODO blocks)...\n"

# Detect best color diff tool
if diff --color=always -u "$TMP1" "$TMP2" &>/dev/null; then
    DIFF_CMD="diff --color=always -u --label TEMPLATE --label TARGET"
elif command -v colordiff &>/dev/null; then
    DIFF_CMD="colordiff -u"
else
    DIFF_CMD="diff -u"
fi

# Run diff with color
$DIFF_CMD "$TMP1" "$TMP2"

STATUS=$?

rm "$TMP1" "$TMP2"

echo
if [[ $STATUS -eq 0 ]]; then
    echo -e "\e[32m✅ Files match (outside TODO blocks)\e[0m"
else
    echo -e "\e[31m❌ Differences found (outside TODO blocks)\e[0m"
fi

exit $STATUS
