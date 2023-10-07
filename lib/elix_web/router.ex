defmodule ElixWeb.Router do
  use ElixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixWeb do
    pipe_through :api

    get "/", PessoaController, :healthcheck
    get "/pessoas", PessoaController, :search
    post "/pessoas", PessoaController, :create
    get "/pessoas/:id", PessoaController, :show
    get "/contagem-pessoas", PessoaController, :count_pessoas
  end
end
