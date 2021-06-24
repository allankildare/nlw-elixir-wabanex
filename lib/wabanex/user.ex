defmodule Wabanex.User do
  use Ecto.Schema
  import Ecto.Changeset

  # variavel de modulo
  @fields [:email, :password, :name]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  # funcao para alteracao de dados no abnco de dados
  def changeset(params) do
    # atalho para referenciar o nome do modulo
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields) # validando campos obrigatorios
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 2)
    |> validate_format(:email, ~r/@/) # validacao de e-mail
    |> unique_constraint([:email]) # checando se ja existe um UUID no banco
  end
end
