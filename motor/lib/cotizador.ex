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

    # Conectamos con Etapa 3 usando los cálculos del flete base
    flete_base = %{flete: flete, cuota_puente: cuota_puente}
    etapa3 = calcular_recargos_etapa3(embarque, reglas, flete_base)
    
    %{
      flete_bruto: flete_bruto,
      descuento: descuento,
      flete: flete,
      cuota_puente: cuota_puente,
      recargo: etapa3.recargo,
      ajuste_minimo: etapa3.ajuste_minimo,
      total: etapa3.total
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

# --- Etapa 3: Recargos y mínimo ---

  defp calcular_recargos_etapa3(embarque, reglas, flete_base) do
    # 1. Obtener datos de recargo por tipo
    %{pct: pct_recargo, fija: fija_recargo} = Map.fetch!(reglas.recargo, embarque.tipo)

    # 2. Obtener la base sobre la que se calcula el recargo (flete o flete + puente)
    base_recargo = obtener_base_recargo(reglas.base_recargo, flete_base.flete, flete_base.cuota_puente)
    recargo = pct(base_recargo, pct_recargo) + fija_recargo

    # 3. Mínimo y ajuste final
    subtotal = flete_base.flete + flete_base.cuota_puente + recargo
    total = max(subtotal, reglas.minimo)
    ajuste_minimo = total - subtotal

    %{
      recargo: recargo,
      ajuste_minimo: ajuste_minimo,
      total: total
    }
  end

  # Cláusulas para la base del recargo
  defp obtener_base_recargo(:flete, flete, _cuota_puente), do: flete
  defp obtener_base_recargo(:subtotal, flete, cuota_puente), do: flete + cuota_puente
  defp obtener_base_recargo(:flete_mas_puente, flete, cuota_puente), do: flete + cuota_puente
  defp obtener_base_recargo(:flete_mas_cuota, flete, cuota_puente), do: flete + cuota_puente


end