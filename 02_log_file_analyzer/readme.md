**Project 2: Log File Analyzer** 

Create a shell script that can analyze a given log file to extract key pieces of information, providing insights into its contents. This script should be versatile enough to perform both simple counts and more detailed data extraction.

**Specific Requirements:**

1.  **Script Argument:** The script must accept the path to the log file as a command-line argument. If no argument is provided, or the file doesn't exist, it should print an error message and exit gracefully.
2.  **Total Log Entries:** Report the total number of lines (log entries) in the file.
3.  **Count Specific Event:** Allow the user to specify a keyword (e.g., "ERROR", "WARNING", "success", a specific IP address) as a *second* command-line argument. The script should then count how many times this keyword appears in the log file. If no keyword is provided, this step can be skipped or report "No keyword specified for counting."
4.  **Most Frequent Entries:** Identify and list the top 5 most frequently occurring *full lines* or *specific fields* (e.g., top 5 requested URLs from an access log if you're working with that format).
