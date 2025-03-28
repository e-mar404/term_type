defmodule TermType.TypingTest do
  defstruct cur_index: 0, 
            letter_map: %{}, 
            status_map: %{}, 
            status: :in_progress

  def new(initial_text) do
    letter_list = 
      initial_text
      |> String.split("", trim: true)
      |> Enum.with_index()

    letter_map =
      for {letter, index} <- letter_list, into: %{}, do: {index, letter}

    status_map =
      for {_letter, index} <- letter_list, into: %{}, do: {index, :background}

    %TermType.TypingTest{letter_map: letter_map, status_map: status_map}
  end

  def attempt(test, attempt) do
    {status, next_index} = check(test.letter_map, test.cur_index, attempt)

    position_to_update = 
      case status do 
        :background -> next_index 
        _ -> test.cur_index 
      end

    new_status_map = Map.put(test.status_map, position_to_update, status)
    
    new_test_status = 
      if position_to_update == map_size(test.letter_map) - 1 do
        :complete
      else
        :in_progress
      end

    %TermType.TypingTest{ test |
      cur_index: next_index,
      status_map: new_status_map,
      status: new_test_status
    }
  end

  defp check(letter_map, index, attempt) do
    correct = Map.get(letter_map, index)  

    cond do
      attempt == "\b" -> {:background, max(index - 1, 0)}
      correct == attempt -> {:correct, index + 1}
      correct != attempt -> {:incorrect, index + 1}
    end 
  end
end
