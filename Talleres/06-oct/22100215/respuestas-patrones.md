# Taller · coincidencia de patrones

Nombre: Carlos Andres Osorio Gonzalez
Número de control: 22100215
Equipo: e02

Copia este archivo a `talleres/06-oct/<tu número de control>/respuestas.md` en el repositorio de tu pareja,
junto con tu `patrones.ex`. Entrega: el mismo día del taller, antes de las 23:59.

## 1. ¿Por qué importa el orden de las cláusulas?
Porque Elixir evalúa las funciones de arriba hacia abajo y se detiene en la primera coincidencia exitosa.

## 2. ¿Qué pasa cuando ninguna cláusula coincide?
Elixir lanza un error de ejecución de tipo FunctionClauseError. Esto es preferible a retornar un valor por omisión en silencio (como nil o false), ya que detiene el flujo temprano al detectar datos con estructuras inesperadas o no previstas, evitando fallos silenciosos más adelante.
El programa lanza un error de tipo FunctionClauseError y la ejecución se detiene.

## 3. Escribiste `documentos_completos?` sin un solo `if`. ¿Cuántas cláusulas usaste y en qué orden?
Usé 5 cláusulas en el siguiente orden:   
def documentos_completos?(%{pedimento: nil}), do: false
def documentos_completos?(%{facturas: []}), do: false
def documentos_completos?(%{tipo: :peligrosa, numero_un: nil}), do: false
def documentos_completos?(%{tipo: :sobredimensionada, permiso: nil}), do: false
def documentos_completos?(_embarque), do: true