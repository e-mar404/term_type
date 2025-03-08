defmodule TermType.TypingTestTest do
  use ExUnit.Case, async: true

  setup do
    test_text = "type test"

    typing_test = TermType.TypingTest.new(test_text)

    letter_map =
      test_text
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {letter, index}, letter_map ->
        Map.put(letter_map, index, letter)
      end)

    status_map = 
      Enum.reduce(0..8, %{}, fn index, status_map -> 
        Map.put(status_map, index, :background)
      end)

    { 
      :ok,
      %{
        typing_test: typing_test,
        letter_map: letter_map,
        status_map: status_map
      }
    }
  end

  test "create a test with given input", context do
    assert context.typing_test.letter_map == context.letter_map
    assert context.typing_test.status_map == context.status_map
    assert context.typing_test.status == :in_progress
  end

  test "correct input as the first try", context do
    expected_status_map = Map.put(context.status_map, 0, :correct)

    expected_test = %TermType.TypingTest{ context.typing_test |
      cur_index: 1,
      status_map: expected_status_map
    }
    
    test_typing_test(["t"], context.typing_test, expected_test)
  end

  test "incorrect input as the first try", context do
    expected_status_map = Map.put(context.status_map, 0, :incorrect)

    expected_test = %TermType.TypingTest{ context.typing_test |
      cur_index: 1,
      status_map: expected_status_map
    }
    
    test_typing_test(["f"], context.typing_test, expected_test)
  end

  test "backspace as the first try", context do
    test_typing_test(["\b"], context.typing_test, context.typing_test)
  end

  test "mixed attempts", context do
    expected_status_map =
      [:correct, :incorrect]
      |> Enum.with_index()
      |> Enum.reduce(context.status_map, fn {status, index}, new_status_map ->
          Map.put(new_status_map, index, status)  
        end)

    expected_test = %TermType.TypingTest{ context.typing_test |
      cur_index: 2,
      status_map: expected_status_map
    }
    
    test_typing_test(["t", "h", "e", "\b"], context.typing_test, expected_test)
  end

  test "get :complete when you finish a test", context do
    expected_status_map =
      Enum.map(0..8, fn _ -> :correct end)
      |> Enum.with_index()
      |> Enum.reduce(context.status_map, fn {status, index}, new_status_map ->
          Map.put(new_status_map, index, status)  
        end)

    expected_test = %TermType.TypingTest{ context.typing_test |
      status: :complete,
      cur_index: 9,
      status_map: expected_status_map
    }
    
    input = ["t", "y", "p", "e", " ", "t", "e", "s", "t"]
    test_typing_test(input, context.typing_test, expected_test)
  end

  defp test_typing_test(input, initial_test, expected_test) do
    new_test = 
      Enum.reduce(input, initial_test, fn attempt, new_test ->
        TermType.TypingTest.attempt(new_test, attempt)
      end)

    assert new_test == expected_test
  end
end
