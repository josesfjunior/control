defmodule Control.Supervisor do
  alias Control.Testes.Genserver
  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def start_child() do
    DynamicSupervisor.start_child(__MODULE__, Genserver)
  end


  @impl true
  def init(init_arg \\ %{max_children: 1000}) do
    DynamicSupervisor.init(
      strategy: :one_for_one,
      extra_arguments: [init_arg]
    )
  end
end