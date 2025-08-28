#!/bin/bash

# Verificar que se haya pasado un argumento
if [ $# -lt 1 ]; then
    echo "Uso: $0 <archivo.asm> [salida]"
    exit 1
fi

# Nombre del archivo fuente (ej: hello.asm)
SRC="$1"

# Verificar que el archivo exista
if [ ! -f "$SRC" ]; then
    echo "Error: el archivo '$SRC' no existe."
    exit 1
fi

# Sacar la extensión .asm para obtener el nombre base
BASENAME=$(basename "$SRC" .asm)

# Nombre de salida (por defecto igual al basename)
OUT="${2:-$BASENAME}"

# Compilación
echo "[*] Compilando $SRC..."
nasm -f elf "$SRC" -o "$BASENAME.o"
if [ $? -ne 0 ]; then
    echo "Error en la compilación."
    exit 1
fi

# Linkedición
echo "[*] Linkeando..."
ld -m elf_i386 "$BASENAME.o" -o "$OUT"
if [ $? -ne 0 ]; then
    echo "Error en la linkedición."
    exit 1
fi

echo "[+] Compilación y linkedición completadas. Ejecutable: $OUT"

