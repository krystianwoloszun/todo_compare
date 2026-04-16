# todo_compare.sh

A small Bash utility for comparing two source code files while **ignoring the contents of `# TODO` blocks**. It highlights real code differences including whitespace and skips anything inside designated TODO regions.

---

## 🚀 Features

- Compares two files side-by-side
- Ignores content inside TODO blocks:
  ```
  # TODO - BLOCK START
  ...
  # TODO - BLOCK END
  ```
- Shows exact:
  - Line numbers
  - Differences (added/removed/modified lines)
  - Whitespace changes
- Colorized terminal output (red/green/cyan)
- Works with any text-based file (not just Python)


## ⚙️ Requirements

- `bash`
- `diff` (standard on most Unix systems)
- Optional but recommonded (for colored output):
  - `colordiff`

---

## 📦 Installation

Make the script executable:

```bash
chmod +x todo_compare.sh
```

(Optional) create an alias in your .bashrc like:

```bash
alias tdcomp="filepath/todo_compare.sh"
```

---

## 🚀 Usage

```bash
./todo_compare.sh template.py target.py
```

Or if aliased:

```bash
tdcomp template.py target.py
```

---

## How it works

1. Reads both input files
2. Strips everything inside TODO blocks:
   ```
   # TODO - BLOCK START
   (ignored content)
   # TODO - BLOCK END
   ```
3. Creates temporary cleaned versions of both files
4. Runs a unified `diff` on the cleaned files
5. Displays colored output if supported
6. Reports whether files match outside TODO blocks

---

## 🎨 Output

- 🟢 **Green message**: Files match outside TODO blocks
- 🔴 **Red message**: Differences found outside TODO blocks
- Unified diff shows exact changes

---


## 🧹 Cleanup

The script automatically removes temporary files created during execution.

---

## 🧩 Notes

- Only blocks marked with exact comments are ignored:
  ```
  # TODO - BLOCK START
  # TODO - BLOCK END
  ```
- Everything outside those blocks is compared normally.
- Nested TODO blocks are not supported.
---

## 📄 License

MIT
