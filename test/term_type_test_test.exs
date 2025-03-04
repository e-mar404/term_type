defmodule TermType.TestTest do
  use ExUnit.Case
  doctest TermType.Test
  
  setup_all do
    TermType.TextBank.start_link()  
    :ok
  end

  test "new test returns an id and text" do
    assert %{id: _test_id, text: _text} = TermType.Test.new 
  end

  test "2 consequtive new tests should be different" do 
   %{id: _, text: text_1} = TermType.Test.new()
   %{id: _, text: text_2} = TermType.Test.new()

   assert text_1 != text_2
  end

end
