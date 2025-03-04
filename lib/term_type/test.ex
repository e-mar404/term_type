defmodule TermType.Test do
  use GenServer

  defstruct [:id, :text]
  
  def new do
    GenServer.start(__MODULE__, nil)
  end

  # TODO: 
  # - make it into a genserver to keep track of auto incrementing ids
  @impl GenServer
  def init(_) do
    {:ok, %TermType.Test{id: 1, text: TermType.TextBank.generate_text()}}
  end
end
