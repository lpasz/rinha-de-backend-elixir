defmodule ElixWeb.PessoaView do
  use ElixWeb, :view
  alias ElixWeb.PessoaView

  def render("index.json", %{pessoas: pessoas}) do
    render_many(pessoas, PessoaView, "pessoa.json")
  end

  def render("show.json", %{pessoa: pessoa}) do
    render_one(pessoa, PessoaView, "pessoa.json")
  end

  def render("pessoa.json", %{pessoa: pessoa}) do
    %{
      id: pessoa.id,
      nome: pessoa.nome,
      apelido: pessoa.apelido,
      stack: String.split(pessoa.stack, " "),
      nascimento: pessoa.nascimento
    }
  end
end
