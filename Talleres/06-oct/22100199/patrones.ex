defmodule Patrones do
  @moduledoc """
  Miercoles 30 · Coincidencia de patrones.

  Regla del dia: ni un solo `if`, `cond` ni `case` sobre el tipo. Cada decision es una
  clausula de funcion. Puedes escribir cuantas clausulas quieras de cada funcion.

      mix test test/patrones_test.exs
  """

  # 1. descripcion/1
  def descripcion(%{tipo: :peligrosa, numero_un: numero_un}) do
    "Carga peligrosa (#{numero_un})"
  end

  def descripcion(%{tipo: :refrigerada}) do
    "Carga refrigerada"
  end

  def descripcion(%{tipo: :general}) do
    "Carga general"
  end

  def descripcion(%{tipo: tipo}) do
    "Carga #{tipo}"
  end


  # 2. documentos_completos?/1
  def documentos_completos?(%{pedimento: nil}), do: false
  def documentos_completos?(%{facturas: []}), do: false
  def documentos_completos?(%{tipo: :peligrosa, numero_un: nil}), do: false
  def documentos_completos?(%{tipo: :sobredimensionada, permiso: nil}), do: false
  def documentos_completos?(_embarque), do: true


  # 3. clasificar_peso/1
  def clasificar_peso(kg) when kg <= 0, do: :invalido
  def clasificar_peso(kg) when kg >= 10_000, do: :pesado
  def clasificar_peso(kg) when kg >= 1_000, do: :medio
  def clasificar_peso(_kg), do: :ligero


  # 4. mensaje/1
  def mensaje({:ok, total}), do: "Total: #{total}"
  def mensaje({:error, motivo}), do: "Rechazado: #{motivo}"


  # 5. primer_id/1
  def primer_id([%{id: id} | _resto]), do: id
  def primer_id([]), do: :vacio
end