#!/bin/bash

usage(){
    cat <<EOF
Usage: $0 [-f <log file path>] 
-f, --logfilepath               Path to log file (required)
-h, --help                      Show help message
-k, --keyword                   Keyword to search in logs
-s, --showmatch                Show matched keyword log
EOF
    return 1
}

system_logger(){
    lprefix="[$(date)]:[$1]::"
    case "$1" in
        [Ii][Nn][Ff][Oo]) printf "${lprefix}${2}\n";;
        [Ee][Rr][Rr][Oo][Rr]) printf "${lprefix}${2}\n";;
        *)
    esac
}

seperator_line(){
    echo "---------------------------------------------------------------------"
}

SHORT_OPTIONS="f:k:hs"
LONG_OPTIONS="logfilepath:,help,keyword:,showmatch"
PARSED=$(getopt --options="$SHORT_OPTIONS" --longoptions="$LONG_OPTIONS" --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
    usage
    return 1
fi

eval set -- "$PARSED"

LOGFILE_PATH=""
declare -a SEARCH_KEYWORDS=()
SHOWMATCHED=false

while true; do
    case "$1" in
    -f|--logfilepath)
        LOGFILE_PATH="$2"
        shift 2
        ;;
    -k|--keyword)
        SEARCH_KEYWORDS+=("$2")
        shift 2
        ;;
    -s|--showmatch)
        SHOWMATCHED=true
        shift
        ;;
    -h|--help)
        usage
        return 0
        ;;
    --)
        shift
        break
        ;;
    *)
        system_logger "ERROR" "Unrecognized option $1"
        usage
        return 1
        ;;
    esac
done

if [[ -z $LOGFILE_PATH ]]; then
    system_logger "ERROR" "You must supply --logfilepath or -f."
    usage
    return 1
fi

system_logger "INFO" "Processing log file \"${LOGFILE_PATH}\""
if [ ! -f "${LOGFILE_PATH}" ]; then
    system_logger "ERROR" "No file found at  \"${LOGFILE_PATH}\""
    return 1
fi

system_logger "INFO" "Generated log summary"
seperator_line
LINES_COUNT=$(wc -l ${LOGFILE_PATH})
system_logger "INFO" "Number of Lines: ${LINES_COUNT}"
seperator_line
echo $SEARCH_KEYWORDS
for word in "${SEARCH_KEYWORDS[@]}"; do
    if [ $SHOWMATCHED == "true" ]; then
        count=0
        echo "Searching for keywork: $word"
        count=$(grep -Fn "$word" "$LOGFILE_PATH")
        echo "$count"
    else
        count=0
        echo "Searching for keywork: $word"
        count=$(grep -Fn "$word" "$LOGFILE_PATH" | wc -l)
        echo "Found $word: $count times!"
    fi
done

seperator_line
system_logger "INFO" "Below are top 3 most recurring lines of logsfile"
sort $LOGFILE_PATH | uniq -c | sort -nr | head -n 3

seperator_line
system_logger "INFO" "Below are top 3 most recurring words of logsfile"
tr -c '["al:]' '[\n*]' < "$LOGFILE_PATH" | grep -v '^$' | sort | uniq -c | sort -nr | head -n 3
