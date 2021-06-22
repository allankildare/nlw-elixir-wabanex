defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  # alias eh um apelido, por padrao eh o ultimo nome
  # nesse caso, IMC
  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  # rota de status OK
  defp handle_response({:ok, result}, conn), do: render_response(conn, result, :ok)

  # rota de bad request
  defp handle_response({:error, result}, conn), do: render_response(conn, result, :bad_request)

  # funcao para renderizacao da resposta
  defp render_response(conn, result, status) do
    conn
    |> put_status(status)
    |> json(%{result: result})
  end
end
