#!/bin/bash

usage(){
    cat <<EOF
Usage: $0 [-f <log file path>] 
-f, --logfilepath               Path to log file (required)
-gl, --generatelogs             Generate log files
-glfc, --generatelogfilecount   Number of log files to create
-llc, --loglinescount           Number of logs entries to be created in logfile
-h, --help                      Show help message
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

gen_log(){
    while [ $count -lt $1 ]; do
        source log_generator.sh "$1" "$2"
        count=$((count + 1))
    done 
}

SHORT_OPTIONS="f:llc:h"
LONG_OPTIONS="logfilepath:generatelogs:generatelogscount:loglinescount:help"
PARSED=$(getopt --options=$SHORT_OPTIONS --longoptions=$LONG_OPTIONS --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
    usage
fi

eval set -- "$PARSED"

LOGFILE_PATH=""
GENERATE_LOGS=false
GENERATE_LOGFILE_COUNT=1
LOG_LINES_COUNT=500

while true; do
    case "$1" in
    -f|--logfilepath)
        LOGFILE_PATH="$2"
        shift 2
        ;;
    -gl|--generatelogs)
        GENERATE_LOGS="$2"
        shift 2
        ;;
    -glfc|--generatelogfilecount)
        GENERATE_LOGFILE_COUNT="$2"
        shift 2
        ;;
    -llc|--loglinescount)
        LOG_LINES_COUNT="$2"
        shift 2
        ;;
    -h|--help)
        usage
        ;;
    --)
        shift
        break
        ;;
    *)
        system_logger "ERROR" "Unrecognized option $1"
        usage
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
system_logger "INFO" "====================="
LINES_COUNT=$(wc -l ${LOGFILE_PATH})
system_logger "INFO" "Number of Lines: ${LINES_COUNT}"