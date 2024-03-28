cmake_minimum_required(VERSION 3.23)
project(Zadanie_2___C C)

set(CMAKE_C_STANDARD 99)

include_directories(SPAASM2)

add_executable(Zadanie_2___C
        SPAASM2/functions.c
        SPAASM2/main.c
        SPAASM2/server.c
        SPAASM2/test.h
        SPAASM2/user.c)
