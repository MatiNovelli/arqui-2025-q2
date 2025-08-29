#!/bin/bash

# Verificar que se haya pasado un argumento
if [ $# -lt 1 ]; then
    echo "Uso: $0 <archivo.asm> [nombre_salida]"
    exit 1
fi

# Nombre del archivo fuente (puede ser ruta relativa como ejercicio1/hello.asm)
SRC="$1"

# Verificar que el archivo exista
if [ ! -f "$SRC" ]; then
    echo "Error: el archivo '$SRC' no existe."
    exit 1
fi

# Obtener directorio del archivo fuente y nombre base
SRC_DIR=$(dirname "$SRC")
BASENAME=$(basename "$SRC" .asm)

# Nombre de salida (por defecto igual al basename)
OUT="${2:-$BASENAME}"

# Ruta completa al archivo lib.asm
LIB_ASM="lib.asm"
if [ ! -f "$LIB_ASM" ]; then
    # Si no está en el directorio actual, buscar en el directorio padre
    LIB_ASM="../lib.asm"
    if [ ! -f "$LIB_ASM" ]; then
        echo "Error: no se encuentra lib.asm"
        exit 1
    fi
fi

# Compilación
echo "[*] Compilando $SRC..."
nasm -f elf "$SRC" -o "$BASENAME.o"
if [ $? -ne 0 ]; then
    echo "Error en la compilación."
    exit 1
fi

echo "[*] Compilando $LIB_ASM..."
nasm -f elf "$LIB_ASM" -o "lib.o"
if [ $? -ne 0 ]; then
    echo "Error compilando lib.asm."
    exit 1
fi

# Linkedición
echo "[*] Linkeando..."
ld -m elf_i386 "$BASENAME.o" "lib.o" -o "$OUT"
if [ $? -ne 0 ]; then
    echo "Error en la linkedición."
    exit 1
fi

# Limpieza
echo "[+] Compilación y linkedición completadas. Ejecutable: $OUT"
rm "$BASENAME.o"
rm "lib.o"