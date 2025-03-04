defmodule TermType.TextBank do
  use GenServer
  
  @total_word_count 1000
  @word_list_path "./persist/english.words"
  
  def start_link(initial_state \\ nil) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end
  
  def generate_text(word_count \\ 25) do
    GenServer.call(__MODULE__, {:generate_text, word_count})    
  end

  def to_letter_map(text) do
    GenServer.call(__MODULE__, {:to_letter_map, text}) 
  end

  @impl GenServer
  def init(_initial_state \\ nil) do
    word_list =
      File.stream!(@word_list_path)
      |> Stream.map(&String.trim/1)
      |> Stream.with_index() 
      |> Enum.to_list()

    word_map = 
      for {word, key} <- word_list, into: %{}, do: {key, word}

    {:ok, word_map} 
  end

  @impl GenServer
  def handle_call({:generate_text, word_count}, _from, word_map) do
    text =
      Enum.map(0..word_count, fn _ ->
        random_index = :rand.uniform(@total_word_count) - 1
        Map.get(word_map, random_index) 
      end)
      |> Enum.join(" ")

    {:reply, text, word_map}
  end

  @impl GenServer
  def handle_call({:to_letter_map, text}, _from, word_map) do
    letter_list = 
      String.split(text, "", trim: true)
      |> Enum.with_index()

    letter_map =
      for {letter, index} <- letter_list, into: %{}, do: {index, letter}

    {:reply, letter_map, word_map}
  end
end
