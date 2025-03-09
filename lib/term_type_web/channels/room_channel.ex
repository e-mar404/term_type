defmodule TermTypeWeb.RoomChannel do
  use TermTypeWeb, :channel

  alias TermType.Handler

  @impl true
  def join("room:lobby", _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_in(event, payload, socket) do
    case Handler.process_message(event, payload) do
      {:ok, result} ->
        push(socket, "response", %{"result" => result})
        {:noreply, socket}
    end
  end
end
