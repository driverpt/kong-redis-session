#! /bin/bash
set -ex

export BUSTED_ARGS="-o gtest -v --exclude-tags=ci"
export TEST_CMD="busted $BUSTED_ARGS"

if [ "$TEST_SUITE" == "lint" ]; then
  make lint
elif [ "$TEST_SUITE" == "unit" ]; then
  make test
else
  createuser --createdb kong
  createdb -U kong kong_tests

  if [ "$TEST_SUITE" == "integration" ]; then
    make test-integration
  fi
fi
