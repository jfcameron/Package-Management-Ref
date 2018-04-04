#!/usr/bin/env bash

cmake .. && make && ctest --extra-verbose
