defmodule ElixWeb.PessoaController do
  use ElixWeb, :controller

  alias Elix.Pessoas
  alias Elix.Pessoas.Pessoa

  action_fallback(ElixWeb.FallbackController)

  def healthcheck(conn, _) do
    conn
    |> put_status(200)
    |> text("")
  end

  def create(conn, params) do
    with {:ok, %Pessoa{} = pessoa} <- Pessoas.create_pessoa(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.pessoa_path(conn, :show, pessoa))
      |> text("")
    end
  end

  def search(conn, %{"t" => term}) do
    with pessoas <- Pessoas.get_pessoa_by_term(term) do
      conn
      |> put_status(200)
      |> render("index.json", pessoas: pessoas)
    end
  end

  def show(conn, %{"id" => id}) do
    pessoa = Pessoas.get_pessoa!(id)
    render(conn, "show.json", pessoa: pessoa)
  end

  def count_pessoas(conn, _params) do
    conn
    |> put_status(200)
    |> text(Pessoas.count_pessoas() |> to_string())
  end
end
