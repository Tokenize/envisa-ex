defmodule EvlDaemon.EventDispatcher do
  @moduledoc """
  This module implements a dispatcher using GenStage and it acts as a producer
  of events.
  """

  alias Experimental.GenStage
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    {:producer, :ok, dispatcher: GenStage.BroadcastDispatcher}
  end

  @doc """
  Enqueue event and dispatch it as soon as possible.
  """
  def enqueue(pid, value) do
    GenStage.cast(pid, {:enqueue, value})
  end

  # Callbacks

  def handle_cast({:enqueue, value}, state) do
    {:noreply, [value], state}
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state}
  end
end
