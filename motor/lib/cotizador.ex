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

  # Función temporal para permitir la compilación
  defp calcular(_embarque, _reglas), do: %{}
end
