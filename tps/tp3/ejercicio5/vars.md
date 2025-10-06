# Resumen y diferencias (caso 1..6)

### 1) `int foo() { int numero; }`

* **Alcance (scope):** local a la función.
* **Duración (lifetime):** automática — vive sólo mientras la función está en ejecución.
* **Memoria:** pila (stack).
* **Inicialización:** *indeterminada* (basura) — no inicializa automáticamente.
* **Linkage:** ninguno (no es visible fuera de la función).
* **Consecuencias:** cada llamada crea su propia celda; devolver la dirección de `numero` es UB (apunta a stack freed). Es reentrante/recursiva: cada llamada tiene su copia en su frame.

---

### 2) `int foo() { int numero = 21; }`

* **Alcance:** local.
* **Duración:** automática (igual que 1), pero **inicializada** al entrar a la función.
* **Memoria:** stack (el compilador puede optimizar y no usar memoria física).
* **Inicialización:** se asigna `21` cada vez que se entra a la función.
* **Linkage:** ninguno.
* **Consecuencias:** comportamiento igual que (1) salvo que `numero` siempre comienza con 21. Sigue sin persistir entre llamadas.

---

### 3)

```c
int numero;
int foo() { numero = 21; }
```

(o alternativamente declarar `int numero;` en scope global)

* **Alcance:** global (a nivel de fichero y visible externamente).
* **Duración:** estática — existe durante toda la ejecución del programa.
* **Memoria:** BSS (si no inicializado explícitamente) — se inicializa a 0 al arrancar.
* **Inicialización:** implícitamente 0 antes de `main`.
* **Linkage:** *extern* por defecto (en C: linkage externa si no `static`).
* **Consecuencias:** compartida por todo el programa/otros módulos; no es segura para hilos sin sincronización. Múltiples definiciones reales (`int numero;`) en diferentes archivos provocan conflicto de linker (a menos que sean `extern`).

---

### 4) `int foo() { static int numero = 21; }`

* **Alcance:** local a la función (solo se puede nombrar dentro de `foo`), pero...
* **Duración:** **estática** — vive durante todo el programa.
* **Memoria:** segmento `.data` (si inicializado) o `.bss` (si sin inicializar).
* **Inicialización:** se inicializa una sola vez (antes de `main` o en la primera llamada, según implementación), y **retiene su valor** entre llamadas.
* **Linkage:** no tiene linkage exterior (no accesible por nombre fuera de la función).
* **Consecuencias:** útil para mantener estado entre llamadas sin exponer la variable a todo el programa.

---

### 5) (uso de `extern`)

Archivo A:

```c
extern int numero;
int foo() { numero = 10; }
```

Archivo B:

```c
int numero = 21;
int bar() { numero = 30; }
```

* **`extern int numero;`** declara una referencia a una **definición global** en otro fichero.
* **Alcance y duración:** la definición real (`int numero = 21;`) es global con duración estática.
* **Memoria:** `.data` (si tiene inicializador) o `.bss` (si sin inicializar).
* **Linkage:** externa — es la forma correcta de compartir una variable global entre módulos.
* **Consecuencias:** `foo()` y `bar()` actúan sobre la misma variable única. El linker requiere exactamente una definición (no varias definiciones con inicializador).

---

### 6) `static int numero = 10; int foo() { numero = 20; }`  (variable `static` a nivel de fichero)

* **Alcance:** fichero (translation unit) — visible sólo dentro del archivo donde se declaró.
* **Duración:** estática (toda la ejecución).
* **Memoria:** `.data` (inicializada) o `.bss`.
* **Linkage:** **interna** (internal linkage) — no puede verse desde otros archivos.
* **Consecuencias:** evita colisiones de nombre entre módulos; mantiene estado entre llamadas pero no exporta la variable al linker.

---

# Puntos prácticos / diferencias clave (resumidas)

* **Stack (locales automáticas)** vs **Data/BSS (estáticos y globales)**.

  * Locals (`int numero;` dentro) → *stack*, vida corta, no inicializado por defecto.
  * Globals/`static` → *.data* o *.bss*, vida larga, inicializados a 0 si no se da valor.
* **Inicialización:**

  * Variables automáticas sin inicializar → valor indeterminado (basura).
  * Globals/static sin inicializador → 0 al inicio del programa.
  * Locales con `= valor` → asignación cada entrada de la función (si automática).
* **Linkage / visibilidad:**

  * `extern` / global sin `static` → *external linkage* (compartida entre archivos).
  * `static` a nivel fichero → *internal linkage* (visible sólo en ese .c).
  * `static` dentro de función → sin linkage global, pero duración estática (retiene valor).
* **Reentrancia/recursión:**

  * Local automática → cada llamada tiene su propia copia (recursiva segura).
  * `static` local / global → compartida entre llamadas (no segura para reentrancia si se modifica).
* **Errores comunes:**

  * Devolver la dirección de una variable automática → puntero a memoria inválida.
  * Definir la misma variable global con inicializador en varios archivos → linker error (multiple definition).
  * Usar `extern` sin una definición real → linker error (undefined reference).