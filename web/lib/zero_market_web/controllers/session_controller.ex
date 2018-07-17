defmodule ZeroMarketWeb.SessionController do
  use ZeroMarketWeb, :controller

  alias ZeroMarketWeb.Accounts.Session

  def new(conn, _params) do
    render conn, "new.html"
  end
 
  def create(conn, params) do
    case Session.login(params["session"]["username"], params["session"]["password"]) do
      {:ok, user} ->
        conn
          |> Guardian.Plug.sign_in(user)
          |> put_flash(:info, "You’re now logged in!")
          |> redirect(to: page_path(conn, :index))
      _ ->
        conn
          |> put_flash(:error, "Invalid email/password combination")
          |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
      |> Guardian.Plug.sign_out()
      |> redirect(to: page_path(conn, :index))
  end
end
