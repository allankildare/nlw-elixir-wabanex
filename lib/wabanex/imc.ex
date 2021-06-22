defmodule Wabanex.IMC do
  # funcao para manipulacao do calculo do IMC
  # a partir da leitura de um arquivo e passando-o para a funcao handle_file()
  def calculate(%{"filename" => filename}) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    data =
      content
      |> String.split("\n")
      |> Enum.map(fn line -> parse_line(line) end)
      |> Enum.into(%{})

    {:ok, data}
  end

  defp handle_file({:error, _reason}) do
    {:error, "Erro ao abrir o arquivo"}
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> List.update_at(1, &String.to_float/1)
    |> List.update_at(2, &String.to_float/1)
    |> calculate_imc()
  end

  # funcao para devolucao do calculo do IMC
  defp calculate_imc([name, height, weight]), do: {name, weight / (height * height)}
end
