#!/usr/bin/env bash

die() {
  echo "$*" >&2
  exit 1
}

validate_arguments() {
  if [[ -z "$2" ]] || [[ "$2" =~ ^-.* ]]; then
      error "'$1' requires one argument"
  fi
}

mycommand::usage() {
  local desc_cmd=
  while read desc_cmd; do
    "$desc_cmd"
  done < <(declare -F|grep "declare -f desc::"|sed "s/^declare -f //"|sort)
}

desc::usage() {
  echo "  ./main.sh [usage|help|-h|--help]"
  echo "    Show me. :)"
}

mycommand::concat() {
  [[ -d "reviews" ]] || mkdir -p "reviews"
  local -r csv_files=$(find reviews -name "*.csv")
  set -- $csv_files
  if let "$# > 0"; then
    ruby concat.rb $csv_files
  else
    die "require at least one csv file."
  fi
}

desc::concat() {
  echo "  ./main.sh [cc|concat]"
  echo "    Concat the csv files in reviews directory."
}

mycommand::query() {
  local -r query="$@"
  q -H -d , "$(echo $query|sed "s/%%f/concat_result.csv/")" #replace placeholder
}

desc::query() {
  echo "  ./main.sh [q|query] 'SELECT * FROM [%%f|file_name] where...'"
  echo "    Query on the specified csv file. "
  echo "    %%f will be replaced with concat_result.csv"
}

EXECUTION_COMMAND=

case "${1:--h}" in
  'query' | 'q' )
    EXECUTION_COMMAND='query'
    ;;
  'concat' | 'cc' )
    EXECUTION_COMMAND='concat'
    ;;
  '-h' | '--help' | 'usage' | 'help' )
    EXECUTION_COMMAND='usage'
    ;;
  -*) # unregistered options
    error "Unknown option '$1'"
    ;;
  *) # arguments which is not option
    error "Unknown arguments '$1'"
    ;;
esac

shift 1

set -f # to disable glob expand
mycommand::${EXECUTION_COMMAND:-usage} "$@"
