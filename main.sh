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
  echo "Hello world"
}

mycommand::concat() {
  [[ -f "reviews" ]] || mkdir -p "reviews"
  local -r csv_files=$(find reviews -name "*.csv")
  set -- $csv_files
  if let "$# > 0"; then
    ruby concat.rb $csv_files
  else
    die "require at least one csv file."
  fi
}

EXECUTION_COMMAND=

case "${1:--h}" in
  'concat' | 'cc' )
    EXECUTION_COMMAND='concat'
    ;;
  '-h' | '--help' )
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

eval "mycommand::${EXECUTION_COMMAND:-usage} $@"
