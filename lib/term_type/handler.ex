defmodule TermType.Handler do
  alias TermType.TypingTest

  def process_message("new_test", _payload) do
    result = 
      TypingTest.new("test type")
      |> Map.from_struct()

    {:ok, result}
  end

  def process_message("attempt", %{"test" => test_map, "attempt" => attempt}) do
    result =
      test_map
      |> TermType.to_struct()
      |> TermType.TypingTest.attempt(attempt)
      |> Map.from_struct()

    {:ok, result} 
  end
end
