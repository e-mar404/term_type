defmodule TermType.TypingTest do
  use Agent

  defstruct next_position: 0, text: ""

  def start_link(_opts) do
    test = %TermType.TypingTest{text: TermType.TextBank.generate_text()}

    Agent.start_link(fn -> test end)
  end

  def attempt(test_pid, attempt) do
    Agent.get_and_update(test_pid, fn test_entry ->
      %{next_position: next_position, text: text} = test_entry

      text
      |> check(attempt, next_position)
      |> color_text()
    end)
  end

  defp check(text, attempt, position) do
    status =
      cond do
        String.at(text, position) == attempt -> :correct
        true -> :incorrect
      end
    {text, status, position}
  end

  defp color_text({text, status, position}) do
    color = 
      case status do
        :correct -> IO.ANSI.green()
        :incorrect -> IO.ANSI.red()
      end

    reset = IO.ANSI.reset()

    {new_text, new_position} = 
      cond do
        position > 0 ->
          left = String.slice(text, 0..(position - 1))
          center = color <> String.at(text, position) <> reset 
          right = String.slice(text, (position + 1 )..String.length(text))
          
          IO.inspect("left: #{left} + center: #{center}, with new position starting at #{String.length(inspect(left))} ")
          {left <> center <> right, String.length(left) + String.length(center)}

        true ->
          left = color <> String.at(text, position) <> reset 
          right = String.slice(text, (position + 1 )..String.length(text))
          
          IO.inspect("center: #{left}, with new position starting at #{String.length(left)}") 
          {left <> right, String.length(left)}
      end

    new_test = 
      %TermType.TypingTest{
        next_position: new_position,
        text: new_text
      }

    {new_test, new_test}
  end
end
