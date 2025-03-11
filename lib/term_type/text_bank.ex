defmodule TermType.TextBank do
  use GenServer   

  @total_word_count 1000
  @word_list_file "./persist/english.words"

  def start_link(initial_state \\ nil) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)  
  end

  def generate_text(length \\ 25) do
    GenServer.call(__MODULE__, {:generate_text, length})  
  end

  @impl true
  def init(_initial_state) do
    word_list =
      File.stream!(@word_list_file)
      |> Stream.map(&String.trim/1)
      |> Stream.with_index()
      |> Enum.to_list()

    IO.inspect(word_list)

    word_map = 
      for {word, index} <- word_list, into: %{}, do: {index, word}

    {:ok, word_map}
  end

  @impl true
  def handle_call({:generate_text, length}, _from, word_map) do
    text =
      Enum.map(1..length, fn _ ->
        random_index = :rand.uniform(@total_word_count) - 1
        Map.get(word_map, random_index)
      end)
      |> Enum.join(" ")

    IO.inspect(text)

    {:reply, text, word_map}
  end
end
