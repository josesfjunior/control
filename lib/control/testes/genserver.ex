defmodule Control.Testes.Genserver do
  use GenServer
  require Logger

  def start_link(number_init \\ 0) do
    GenServer.start_link(__MODULE__, number_init, name: __MODULE__)
  end

  def add(pid, number \\ 1) do
    GenServer.call(pid, {:add, number})
  end

  def subtract(pid, number) do
    GenServer.call(pid, {:subtract, number})
  end

  def view(pid) do
    GenServer.call(pid, :view)
  end

#  def stop(pid) do
#    GenServer.stop(pid, :normal, :infinity)
#  end

#  def terminate(_reason, _list) do
#    IO.puts("É só isso, não tem mais jeito, acabou")
#    :ok
#  end

#  def call(pid ,number \\ 0 ) do
#    GenServer.cast(pid, {:run, number})
#    :timer.sleep(1000)
#    number_up = number + 1
#  end


  @impl true
  def handle_call({:add, number}, _from, state) do
    {:reply, "adding #{number}", state + number}
  end

  def handle_call({:subtract, number}, _from, state) do
    {:reply, "subtract #{number}", state - number}
  end

  def handle_call(:view, _from, list) do
    {:reply, list, list}
  end

  @impl true
  def init(number) do
    {:ok, number}
  end


end