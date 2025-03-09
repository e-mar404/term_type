defmodule TermTypeWeb.Router do
  use TermTypeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TermTypeWeb do
    pipe_through :api
  end
end
