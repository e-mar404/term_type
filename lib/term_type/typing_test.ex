defmodule TermType.TypingTest do
  defstruct next_position: 0, letter_map: %{}, status_map: %{}

  def start_link() do
    letter_map = 
      TermType.TextBank.generate_text()
      |> TermType.TextBank.to_letter_map()

    status_map =
      for {index, _letter} <- letter_map, into: %{}, do: {index, :background}

    %TermType.TypingTest{
      letter_map: letter_map,
      status_map: status_map
    }
  end
end
