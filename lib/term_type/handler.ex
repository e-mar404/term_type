defmodule TermType.Handler do
  alias TermType.TypingTest

  def process_message("new_test", _payload) do
    result = 
      TypingTest.new("test type")
      |> Map.from_struct()

    {:ok, result}
  end
end
