defmodule CrudGraphqlElixir.Application do
  use Application

  def start(_type, _args) do
    CrudGraphqlElixir.EnvLoader.load_env()

    children = [
      CrudGraphqlElixir.Repo,
      {Redix, name: :redix, host: System.get_env("REDIS_HOST"), port: String.to_integer(System.get_env("REDIS_PORT"))},
      {Phoenix.PubSub, name: CrudGraphqlElixir.PubSub},
      CrudGraphqlElixir.Endpoint
    ]

    opts = [strategy: :one_for_one, name: CrudGraphqlElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    CrudGraphqlElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
