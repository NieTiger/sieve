cmake_minimum_required(VERSION 3.14)
project(sieve)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_BUILD_TYPE "Release")
add_executable(sieve
  main.cpp
  sieve.cpp
  )
