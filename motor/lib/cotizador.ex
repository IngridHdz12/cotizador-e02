defmodule Cotizador do
  @moduledoc """
  Motor de cotizaciones para fletes de transporte terrestre.
  """

  @tipos [:general, :refrigerada, :peligrosa, :sobredimensionada]

  @doc """
  Cotiza un embarque si pasa las validaciones de negocio.
  """
  def cotizar(embarque, reglas) do
    with :ok <- validar(embarque, reglas) do
      {:ok, calcular(embarque, reglas)}
    end
  end

  # --- Etapa 1: Validaciones de rechazo (en orden estricto) ---

  # 1. Peso cero o negativo
  defp validar(%{peso_kg: p}, _reglas) when p <= 0, do: {:error, :peso_invalido}

  # 2. Distancia cero o negativa
  defp validar(%{distancia_km: d}, _reglas) when d <= 0, do: {:error, :distancia_invalida}

  # 3. Tipo de carga desconocido
  defp validar(%{tipo: t}, _reglas) when t not in @tipos, do: {:error, :tipo_desconocido}

  # 4. Puente no existente en las reglas
  defp validar(%{puente: p}, %{cuota_puente: cuotas}) when not is_map_key(cuotas, p),
    do: {:error, :puente_desconocido}

  # 5. Carga peligrosa sin número UN
  defp validar(%{tipo: :peligrosa, numero_un: un}, _reglas) when is_nil(un) or un == "",
    do: {:error, :falta_numero_un}

  # 6. Carga sobredimensionada sin permiso
  defp validar(%{tipo: :sobredimensionada, permiso: permiso}, _reglas)
       when is_nil(permiso) or permiso == "",
       do: {:error, :falta_permiso}

  # Carga sobredimensionada con permiso: no tiene límite de peso
  defp validar(%{tipo: :sobredimensionada}, _reglas), do: :ok

  # 7. Excede el peso máximo permitido
  defp validar(%{peso_kg: p}, %{peso_maximo_kg: max}) when p > max,
    do: {:error, :excede_peso_maximo}

  # Si pasa todas las validaciones
  defp validar(_embarque, _reglas), do: :ok

  # --- Etapa 2: El flete ---

  defp calcular(embarque, reglas) do
    flete_bruto = embarque.distancia_km * reglas.tarifa_km

    descuento = obtener_descuento(embarque.peso_kg, flete_bruto, reglas.descuento)
    flete = flete_bruto - descuento
    cuota_puente = Map.fetch!(reglas.cuota_puente, embarque.puente)

    %{
      flete_bruto: flete_bruto,
      descuento: descuento,
      flete: flete,
      cuota_puente: cuota_puente,
      # Se mantienen en 0 para esta etapa
      recargo: 0,
      # Se mantienen en 0 para esta etapa
      ajuste_minimo: 0,
      total: flete + cuota_puente
    }
  end

  # función de redondeo 
  defp pct(monto, p), do: div(monto * p + 50, 100)

  # cláusulas de descuento en orden
  defp obtener_descuento(peso, flete_bruto, %{criterio: :a_partir_de, umbral_kg: u, pct: p})
       when peso >= u do
    pct(flete_bruto, p)
  end

  defp obtener_descuento(peso, flete_bruto, %{criterio: :mas_de, umbral_kg: u, pct: p})
       when peso > u do
    pct(flete_bruto, p)
  end

  defp obtener_descuento(_peso, _flete_bruto, _reglas_desc) do
    0
  end
end
