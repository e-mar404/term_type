# TermType

## Description

This will be the server instance that will serve the API of a typing test
backend. The server will connect through Web Sockets to the client (which can be
written in any language, but because I want to make the client facing typing
test on the terminal will be in go).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `term_type` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:term_type, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/term_type>.
