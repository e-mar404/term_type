defmodule Todo.ListTest do
  use ExUnit.Case, async: true

  test "see if i get the updated state" do
    TermType.TextBank.start_link()

    TermType.TypingTest.start_link()
    |> TermType.TypingTest.attempt("t")
    |> TermType.TypingTest.attempt("h")
    |> TermType.TypingTest.attempt("e")
    |> TermType.TypingTest.attempt("\b")
    |> TermType.TypingTest.attempt("\b")
    |> TermType.TypingTest.render()
  end
end
