#!/usr/bin/env bash

#### Author: 
#### Date:
#### Description:  

readonly _SCRIPT_NAME=$(basename "$0")
readonly _SCRIPT_DIR=$(readlink -m "$(dirname "$0")")
readonly _SCRIPT_ARGS="$@"

function _usage {
  cat <<- EOF
    Usage: ${_SCRIPT_NAME} [OPTIONS]

    <description>
    
    OPTIONS:
      -h --help           Show this help message
      -x --debug          Run script in debug mode

    Examples:
      Show help message:
        ${_SCRIPT_NAME} --help
	EOF
}

# Abort script at first error, when a command exits with non-zero status.
set -o errexit
# Causes a pipeline to return the exit status of the last command in the pipe
# that returned a non-zero return value.
set -o pipefail
# Attempt to use undefined variable outputs error message, and forces an exit.
# Rejects environment variables as well!
set -o nounset

function _cmdline {
	if [ "$#" -eq 0 ]; then
		_usage
    exit 0
	fi

  options=$(getopt -o hx --long help,debug -- "$@")

  [ $? -eq 0 ] || {
      echo "Unrecognized option provided"
      exit 1
  }

  eval set -- "${options}"

  while true
  do
      case "$1" in
          -h)
              _usage
              exit 0
              ;;
          --help)
              _usage
              exit 0
              ;;
          -x)
              readonly DEBUG='-x'
              set -x
              shift
              ;;
          --debug)
              readonly DEBUG='-x'
              set -x
              shift
              ;;
          --)
              shift
              break
              ;;
          *)
              echo "$0: unparseable option $1"
              exit 1
              ;;
      esac
  done
}

function _main {
  _cmdline $_SCRIPT_ARGS
}

_main
