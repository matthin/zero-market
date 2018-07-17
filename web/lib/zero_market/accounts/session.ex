defmodule ZeroMarketWeb.Accounts.Session do 
  import Ecto.Query, warn: false
  
  alias ZeroMarket.Repo
  alias ZeroMarket.Accounts.User
  
  def login(username, password) do
    user = Repo.get_by(User, username: username)
    case authenticate(user, password) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  def authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Argon2.checkpw(password, user.password_hash)
    end
  end
end
