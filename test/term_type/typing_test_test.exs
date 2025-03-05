defmodule Todo.ListTest do
  use ExUnit.Case, async: true

  test "see if i get the updated state" do
    TermType.TextBank.start_link()
    {:ok, test_pid} = TermType.TypingTest.start_link(nil)

    TermType.TypingTest.attempt(test_pid, "t")
    TermType.TypingTest.attempt(test_pid, "h")
    %{next_position: _next_position, text: text} = TermType.TypingTest.attempt(test_pid, "e")

    IO.puts text
  end
end
