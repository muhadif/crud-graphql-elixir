defmodule CrudGraphqlElixir.Repo do
  use Ecto.Repo,
    otp_app: :crud_graphql_elixir,
    adapter: Ecto.Adapters.MyXQL
end
