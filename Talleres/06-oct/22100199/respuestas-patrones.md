# Taller · coincidencia de patrones

Nombre: Ingrid Annete Hernández Montoya
Número de control: 22100199
Equipo: e02

Copia este archivo a `talleres/06-oct/<tu número de control>/respuestas.md` en el repositorio de tu pareja,
junto con tu `patrones.ex`. Entrega: el mismo día del taller, antes de las 23:59.

## 1. ¿Por qué importa el orden de las cláusulas?

En Elixir, las cláusulas de una función se evalúan en orden secuencial de arriba hacia abajo. Si colocamos la cláusula comodín def documentos_completos?(_embarque), do: true al inicio de la función, esta atrapará cualquier parámetro de entrada inmediatamente. Las cláusulas específicas que devuelven false (como las que verifican pedimento: nil o facturas: []) nunca llegarían a ejecutarse.

## 2. ¿Qué pasa cuando ninguna cláusula coincide?

Elixir lanza un error de ejecución de tipo FunctionClauseError. Esto es preferible a retornar un valor por omisión en silencio (como nil o false), ya que detiene el flujo temprano al detectar datos con estructuras inesperadas o no previstas, evitando fallos silenciosos más adelante.

## 3. Escribiste `documentos_completos?` sin un solo `if`. ¿Cuántas cláusulas usaste y en qué orden?

Usé 5 cláusulas en el siguiente orden:   
def documentos_completos?(%{pedimento: nil}), do: false
def documentos_completos?(%{facturas: []}), do: false
def documentos_completos?(%{tipo: :peligrosa, numero_un: nil}), do: false
def documentos_completos?(%{tipo: :sobredimensionada, permiso: nil}), do: false
def documentos_completos?(_embarque), do: true