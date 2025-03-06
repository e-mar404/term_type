defmodule Todo.ListTest do
  use ExUnit.Case, async: true

  test "see if i get the updated state" do
    TermType.TextBank.start_link()

    IO.inspect(TermType.TypingTest.start_link())
  end
end
