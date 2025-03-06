defmodule TermType.TypingTest do
  defstruct next_position: 0, rendered_text: "", letter_map: %{}

  def start_link() do
    letter_map = 
      TermType.TextBank.generate_text()
      |> TermType.TextBank.to_letter_map()

    rendered_text = color(letter_map, :all, :background)

    {rendered_text, letter_map}
  end

  defp color(letter_map, :all, :background) do
    Enum.map(0..(map_size(letter_map) - 1), fn index ->
      IO.ANSI.faint() <> Map.get(letter_map, index) <> IO.ANSI.reset()
    end)  
    |> Enum.join()
  end
end
