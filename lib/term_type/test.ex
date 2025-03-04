defmodule TermType.Test do
  defstruct [:id, :text]

  def new do
    %TermType.Test{id: 1, text: TermType.TextBank.generate_text()} 
  end
end
