defmodule Elix.Pessoas do
  import Ecto.Query, warn: false
  alias Elix.Repo

  alias Elix.Pessoas.Pessoa

  def count_pessoas do
    Repo.aggregate(Pessoa, :count)
  end

  def get_pessoa!(id), do: Repo.get!(Pessoa, id)

  def create_pessoa(attrs \\ %{}) do
    %Pessoa{}
    |> Pessoa.changeset(attrs)
    |> Repo.insert()
  end

  def get_pessoa_by_term(term) do
    term
    |> Pessoa.by_term()
    |> Repo.all()
  end
end
