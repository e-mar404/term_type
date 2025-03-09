defmodule TermTypeWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :term_type

  socket "/socket", TermTypeWeb.UserSocket,
    websocket: true,
    longpoll: false
  
  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]
  
  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session,
    store: :cookie,
    key: "_websocket_server_key",
    signing_salt: "random_salt"

  plug TermTypeWeb.Router
end
