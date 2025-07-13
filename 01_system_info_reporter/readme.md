# Project 01: System Info Reporter

A Bash script that collects and displays essential Linux system information in a clear, organized format for a quick system overview.

## Features

* **Current date & time**
* **Active user**
* **System uptime**
* **Operating System details**
* **Kernel version**
* **CPU information**
* **Memory usage**
* **Disk usage statistics**
* **Top memory and CPU consuming processes**

## Requirements

* Linux operating system
* Bash shell
* Standard Unix utilities: `uname`, `date`, `whoami`, `uptime`, `grep`, `awk`, `top`, `df`, `free`

## Installation

1. **Clone the repository** (or navigate to the project folder if already cloned):

   ```bash
   git clone https://github.com/vijayrmourya/shell-automation.git
   cd shell-automation/01_system_info_reporter
   ```
2. **Make the script executable**:

   ```bash
   chmod +x system_info_reporter.sh
   ```

## Usage

Run the script to generate the system report:

```bash
source system_info_reporter.sh
```

## Contributing

Contributions, issues, and feature requests are welcome! Please open an issue or submit a pull request.
