defmodule TermType.TypingTestTest do
  use ExUnit.Case, async: true

  setup do
    typing_test = TermType.TypingTest.new("type test")

    letter_map = %{
      0 => "t",
        1 => "y", 
        2 => "p",
        3 => "e",
        4 => " ",
        5 => "t",
        6 => "e",
        7 => "s",
        8 => "t"
    }

    status_map = %{
      0 => :background,
        1 => :background, 
        2 => :background,
        3 => :background,
        4 => :background,
        5 => :background,
        6 => :background,
        7 => :background,
        8 => :background
    }

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
  end

  test "correct input as the first try", context do
    new_test = TermType.TypingTest.attempt(context.typing_test, "t")
    updated_status_map = Map.put(context.status_map, 0, :correct)

    assert new_test.status_map == updated_status_map
    assert new_test.cur_index == 1
  end
end
