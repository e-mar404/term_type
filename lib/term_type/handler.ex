defmodule TermType.Handler do
  alias TermType.TextBank
  alias TermType.TypingTest

  def process_message("new_test", %{"manually_generate" => text}) do
  result = 
    text
    |> TypingTest.new()
    |> Map.from_struct()

    {:ok, result}
  end

  def process_message("new_test", _payload) do
    genereated_test = TextBank.generate_text()

    result = 
      genereated_test
      |> TypingTest.new()
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
