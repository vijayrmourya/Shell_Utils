# Shell_Utils

A collection of Bash scripts to automate routine system administration tasks and to serve as hands-on shell scripting exercises.

---

## Introduction

**Shell_Utils** is a curated suite of Bash scripts intended:

- To automate everyday admin workflows  
- To illustrate best-practices in shell scripting  
- To provide a learning platform for system-level tooling
- Some simple just for fun projects

---

## Projects

Each subfolder is a standalone mini-project with its own scripts and examples.  
Below is the high-level overview; see each folder’s README for in-depth docs.

| Folder                   | Description                                        |
|--------------------------|----------------------------------------------------|
| `01_system_info_reporter`| Generates a concise system report (date/time, OS/kernel info, uptime, hardware metrics, …) |
| `02_log_file_analyzer`   | Parses and summarizes log files (error counts, top IPs/users, rotation helpers, …) |
| `03_dir_file_counter`    | Counts files and subdirectories, optionally by extension or size |
| `shell-basics`           | Shell “toy” scripts demonstrating CPU/memory checks, disk inspections, network diagnostics, and more |

---

## Installation

1. **Clone the repo**  
   ```bash
   git clone https://github.com/vijayrmourya/Shell_Utils.git
   cd Shell_Utils
   ```

2. **Make scripts executable**

   ```bash
   chmod +x */*.sh
   ```
3. **(Optional) Install dependencies**

   * Bash ≥ 4.0
   * coreutils, grep, awk, sed, etc.

---

## Usage

Run any script directly:

```bash
./01_system_info_reporter/system_info.sh [options]
```

For each project folder:

1. `cd 01_system_info_reporter`
2. `./<script>.sh --help`

---

## Features

* **System Info Reporter**

  * Current date & time
  * Logged-in user
  * OS & kernel details
  * Uptime & load averages
  * CPU, memory & disk stats

* **Log File Analyzer**

  * Error/warning counts
  * Top N active IPs or users

* **Directory/File Counter**

  * Total file & directory counts
  * Filter by extension, age, or size
  * Recursive or depth-limited scans

* **Shell Basics**

  * CPU & memory monitoring
  * Disk & USB device inspection
  * Basic network diagnostics (ping, traceroute)

---

## Dependencies

* **Bash** (tested on versions *X.Y – Z.W*)
* **GNU coreutils** (ls, du, df, etc.)
* **awk**, **sed**, **grep**

---

## Troubleshooting

* **Permission denied**
  Ensure scripts are executable: `chmod +x *.sh`.

* **Missing command**
  Install required tools, e.g. `sudo apt-get install coreutils lsof`.

* **Unexpected output**
  Check your config file and ensure environment variables are set correctly.

---

## Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/foo`)
3. Commit changes (`git commit -m 'Add foo script'`)
4. Push (`git push origin feature/foo`)
5. Open a Pull Request

Please follow the existing code style and include tests/examples for any new scripts.

---
