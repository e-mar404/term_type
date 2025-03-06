defmodule Todo.ListTest do
  use ExUnit.Case, async: true

  test "see if i get the updated state" do
    TermType.TextBank.start_link()

    {text, _map} = TermType.TypingTest.start_link()

    IO.puts(text)
  end
end
