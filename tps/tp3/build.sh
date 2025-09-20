#!/bin/bash

# Uso: ../build.sh [-64] main.asm [archivos.c ...]

# Valores por defecto
BITS=32
ASM_FORMAT="elf32"
GCC_FLAG="-m32"

# Verificar si el primer argumento es -64
if [ "$1" == "-64" ]; then
    BITS=64
    ASM_FORMAT="elf64"
    GCC_FLAG="-m64"
    shift  # quitamos el -64 de los argumentos
fi

# Verificar que se haya pasado al menos un archivo .asm
if [ -z "$1" ]; then
    echo "Uso: $0 [-64] archivo.asm [archivos.c ...]"
    exit 1
fi

ASM_FILE="$1"
ASM_BASE=$(basename "$ASM_FILE" .asm)
shift

# Compilar el assembler
nasm -f $ASM_FORMAT "$ASM_FILE" -o "$ASM_BASE.o"
if [ $? -ne 0 ]; then
    echo "Error compilando $ASM_FILE"
    exit 1
fi

# Si no hay archivo C, linkear directamente
if [ $# -eq 0 ]; then
    gcc $GCC_FLAG "$ASM_BASE.o" -o "$ASM_BASE" 2>/dev/null
    rm -f "$ASM_BASE.o"   # borrar .o
    exit $?
fi

# Si hay uno o más archivos C
OBJ_FILES="$ASM_BASE.o"
for C_FILE in "$@"; do
    C_BASE=$(basename "$C_FILE" .c)
    gcc -c $GCC_FLAG "$C_FILE" -o "$C_BASE.o"
    if [ $? -ne 0 ]; then
        echo "Error compilando $C_FILE"
        exit 1
    fi
    OBJ_FILES="$OBJ_FILES $C_BASE.o"
done

# Linkear ASM y C (silenciar warnings del linker)
OUTPUT=$(basename "$1" .c) # el nombre del ejecutable será el del primer .c
gcc $GCC_FLAG $OBJ_FILES -o "$OUTPUT" 2>/dev/null

# Borrar los .o
rm -f $OBJ_FILES
