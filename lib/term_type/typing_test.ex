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

  def attempt(test, input) do 
    {status, next_position} = check(test.letter_map, test.next_position, input)

    new_status_map = 
      case status do
        :background -> Map.put(test.status_map, next_position, status)
        _ -> Map.put(test.status_map, test.next_position, status)
      end

    %TermType.TypingTest{ test |
      next_position: next_position,
      status_map: new_status_map
    }
  end
  
  def render(test) do
    Enum.map(0..map_size(test.letter_map) - 1, fn index -> 
      letter = Map.get(test.letter_map, index)
      status = Map.get(test.status_map, index)

      color(letter, status)   
    end)
    |> Enum.join()
    |> IO.puts()
  end

  defp check(letter_map, position, input) do
    correct_letter = Map.get(letter_map, position)

    cond do
      input == "\b" -> {:background, max(position - 1, 0)}
      correct_letter == input -> {:correct, position + 1}
      correct_letter != input -> {:incorrect, position + 1}
    end
  end

  defp color(letter, :background), do: IO.ANSI.faint() <> letter <> IO.ANSI.reset()
  defp color(letter, :correct), do: IO.ANSI.green() <> letter <> IO.ANSI.reset()
  defp color(" ", :incorrect), do: IO.ANSI.red() <> "_" <> IO.ANSI.reset()
  defp color(letter, :incorrect), do: IO.ANSI.red() <> letter <> IO.ANSI.reset()
end
