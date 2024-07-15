import Config

config :crud_graphql_elixir, ecto_repos: [CrudGraphqlElixir.Repo],
       username: System.get_env("DATABASE_USERNAME"),
       password: System.get_env("DATABASE_PASSWORD"),
       database: System.get_env("DATABASE_NAME"),
       hostname: System.get_env("DATABASE_HOSTNAME"),
       show_sensitive_data_on_connection_error: true,
       pool_size: 10

config :redix,
       host: System.get_env("REDIS_HOST"),
       port: String.to_integer(System.get_env("REDIS_PORT"))
