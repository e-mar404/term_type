import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :term_type, TermTypeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "KfK4dCg4+H6M65QTRfA/RdiUfzrAk6mFIu5gPyKS+SpQisds6xsIuHoVkQ8eMsh6",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
