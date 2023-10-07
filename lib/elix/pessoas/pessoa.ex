defmodule Elix.Pessoas.Pessoa do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pessoas" do
    field(:apelido, :string)
    field(:nascimento, :date)
    field(:nome, :string)
    field(:search, :string)
    field(:stack, :string)
  end

  @doc false
  def changeset(pessoa, attrs) do
    pessoa
    |> cast(maybe_parse_stack(attrs), [:nome, :apelido, :stack, :nascimento])
    |> validate_required([:nome, :apelido, :nascimento])
    |> unique_constraint(:apelido, name: :pessoas_apelido_key)
  end

  defp maybe_parse_stack(attrs) do
    stack = attrs["stack"]

    if stack != nil and not is_binary(stack) and Enum.all?(stack, &is_binary/1) do
      stack = Enum.join(stack, " ")
      Map.put(attrs, "stack", stack)
    else
      attrs
    end
  end

  def by_term(q \\ __MODULE__, term) do
    where(q, [p], ilike(p.search, ^"%#{term}%"))
  end
end
