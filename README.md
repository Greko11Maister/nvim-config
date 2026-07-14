# Guía rápida de Neovim

Leader key = `Space`

## Barra de archivos (neo-tree)

| Atajo | Acción |
|---|---|
| `Ctrl + n` | Abrir / cerrar barra lateral |
| `Space b f` | Revelar archivo actual en la barra |
| `h` / `l` | Colapsar / expandir carpeta |

## Buscador (telescope)

| Atajo | Acción |
|---|---|
| `Space f f` | Buscar archivos por nombre |
| `Space f g` | Buscar texto en todo el proyecto |
| `Space f b` | Ver buffers abiertos |
| `Space f r` | Archivos recientes |
| `Space f h` | Buscar en ayuda |
| `Space f d` | Diagnósticos de todo el workspace |
| `Space f s` | Símbolos del archivo actual |

## Código — LSP

| Atajo | Acción |
|---|---|
| `g d` | Ir a la definición |
| `g r` | Ver referencias |
| `g i` | Ir a la implementación |
| `g D` | Ir a la declaración |
| `K` | Ver documentación (hover) |
| `Space r n` | Renombrar símbolo |
| `Space c a` | Acciones de código (auto-import, quick fix...) |
| `[ d` | Ir al error / diagnóstico anterior |
| `] d` | Ir al siguiente error / diagnóstico |
| `Space e` | Mostrar error en ventana flotante |

### Ejemplo: navegar a una definición
```
1. Posicionate sobre una clase o función
2. Apretá g d
```

## Autocompletado (nvim-cmp)

| Atajo | Acción |
|---|---|
| `Tab` | Siguiente sugerencia |
| `Shift + Tab` | Anterior sugerencia |
| `Enter` | Confirmar selección |
| `Ctrl + Space` | Forzar autocompletado |
| `Ctrl + e` | Cerrar menú |

## Formateo (conform)

| Atajo | Acción |
|---|---|
| `Space f` | Formatear archivo manualmente |

También se formatea **automáticamente al guardar** (`:w`).

## Terminal integrada (toggleterm)

| Atajo | Acción |
|---|---|
| `Ctrl + \` | Abrir / cerrar terminal flotante |
| `Space t f` | Terminal flotante nueva |
| `Space t h` | Terminal en split horizontal |
| `Space t v` | Terminal en split vertical |

Dentro del terminal:
- `i` → modo input (escribir comandos)
- `Ctrl + \` → cerrar y volver al código
- Copia y pega con el mouse habilitado

## Git (gitsigns)

| Atajo | Acción |
|---|---|
| `[ c` | Hunk anterior |
| `] c` | Siguiente hunk |
| `Space g b` | Git blame de la línea |
| `Space g h` | Previsualizar cambios del hunk |
| `Space g r` | Revertir hunk |

## Debugging (nvim-dap)

| Atajo | Acción |
|---|---|
| `Space d b` | Toggle breakpoint en la línea actual |
| `Space d B` | Breakpoint condicional (pide una expresión) |
| `Space d c` | Iniciar / continuar ejecución |
| `Space d o` | Step over (siguiente línea) |
| `Space d i` | Step into (entrar en función) |
| `Space d u` | Step out (salir de función) |
| `Space d t` | Terminar sesión de debug |
| `Space d r` | Abrir REPL (consola interactiva) |
| `Space d l` | Repetir última configuración de debug |
| `Space d u i` | Abrir / cerrar panel de debug (variables, call stack, etc.) |
| `Space d e` | Evaluar expresión (en modo visual evalúa la selección) |

### Cómo debuggear NestJS (TypeScript backend)

```
1. Agregá --inspect al script de NestJS:
   node --inspect -r ts-node/register src/main.ts

2. En nvim: Space d c → seleccioná "Attach to Node process" → elegí el PID

3. O usá "Debug NestJS" que lo lanza desde nvim directamente.
```

### Cómo debuggear Angular (Chrome frontend)

```
1. Opción A — Attach (recomendado):
   a. Cerrá todas las ventanas de Chrome.
   b. Abrí Chrome con remote debugging:
      open -a "Google Chrome" --args --remote-debugging-port=9222
   c. Abrí http://localhost:4200 en ese Chrome.
   d. En nvim: Space d c → "Attach to Angular (Chrome :9222)"

2. Opción B — Launch desde nvim:
   Space d c → "Launch Angular (Chrome)" → abre Chrome automáticamente.
```

### Cómo debuggear Rust

```
1. Compilá en modo debug: cargo build
2. Space d c → "Launch Rust binary" → ingresá la ruta al binario
```

### Cómo debuggear Java

```
1. Agregá -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
   al comando de java

2. En nvim: Space d c → "Attach to JVM (port 5005)"
```

## Gestión de LSPs (Mason)

| Comando | Acción |
|---|---|
| `:Mason` | Abrir panel para instalar/desinstalar LSPs y herramientas |
| `:LspInfo` | Ver estado de los servidores LSP activos |
| `:checkhealth` | Diagnóstico general de Neovim |

## Básicos de Neovim

| Comando / Atajo | Acción |
|---|---|
| `Esc` | Volver a modo normal |
| `i` | Insertar antes del cursor |
| `a` | Insertar después del cursor |
| `o` | Nueva línea abajo y entrar en modo inserción |
| `:w` | Guardar archivo |
| `:q` | Cerrar ventana |
| `:wq` | Guardar y cerrar |
| `:qa` | Salir de Neovim |
| `/texto` | Buscar en el archivo, `n` para siguiente, `N` para anterior |
| `u` | Deshacer |
| `Ctrl + r` | Rehacer |

---

## Plugins instalados

| Plugin | Función |
|---|---|
| catppuccin | Tema Catppuccin Mocha |
| telescope.nvim | Buscador fuzzy de archivos y texto |
| neo-tree.nvim | Barra lateral de archivos |
| nvim-lspconfig + mason | Servidores LSP (autocompletado, diagnóstico, navegación) |
| nvim-cmp | Motor de autocompletado |
| nvim-treesitter | Coloreado de sintaxis avanzado |
| conform.nvim | Formateo automático al guardar |
| gitsigns.nvim | Indicadores de cambios de Git en el gutter |
| nvim-autopairs | Cierre automático de paréntesis y brackets |
| which-key.nvim | Muestra atajos disponibles mientras escribís |
| nvim-dap + nvim-dap-ui | Debugger con breakpoints, variables, call stack |
| mason-nvim-dap | Instalación automática de debug adapters |
| toggleterm.nvim | Terminal integrada con un solo atajo |

## LSPs configurados

| Servidor | Lenguaje |
|---|---|
| ts_ls | TypeScript / JavaScript |
| angularls | Angular |
| rust_analyzer | Rust |
| jdtls | Java |
| lua_ls | Lua |
| html / cssls / jsonls | HTML, CSS, JSON |

> Al abrir un archivo por primera vez, Mason instala automáticamente el LSP que falta.
