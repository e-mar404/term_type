defmodule TermType.Application do
  use Application 

  @impl true
  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: TermType.PubSub},
      TermTypeWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: TermType.Supervisor]

    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    TermTypeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
