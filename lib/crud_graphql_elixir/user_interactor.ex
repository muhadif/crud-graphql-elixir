defmodule GraphqlCleanArchitecture.UserInteractor do
  alias GraphqlCleanArchitecture.{Repo, User}
  alias Redix, as: Redis

  def get_user(id) do
    case Redis.command!(:redix, ["GET", "user:#{id}"]) do
      nil ->
        case Repo.get(User, id) do
          nil -> {:error, "User not found"}
          user ->
            Redis.command!(:redix, ["SET", "user:#{user.id}", Jason.encode!(user)])
            {:ok, user}
        end

      cached_user ->
        {:ok, Jason.decode!(cached_user, as: %User{})}
    end
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
