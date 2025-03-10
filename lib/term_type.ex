defmodule TermType do
  alias TermType.TypingTest

  def to_struct(map) do
    struct(TypingTest, %{
        cur_index: map["cur_index"],
        letter_map: map["letter_map"] |> to_keyyed_map(),
        status_map: map["status_map"] |> to_keyyed_map(true),
        status: map["status"] |> to_atom()
    })
  end  
  
  defp to_keyyed_map(map, atom_value \\ false) do
    for {index, value} <- map, into: %{} do
      updated_value = 
        if atom_value do
          value |> to_atom()
        else 
          value
        end

      {String.to_integer(index), updated_value}
    end
  end

  defp to_atom(str) when is_binary(str), do: String.to_atom(str)
  defp to_atom(value), do: value
end
