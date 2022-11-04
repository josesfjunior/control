defmodule ControlWeb.LiveHome do
  use Phoenix.LiveView

  require Logger
  alias Control.Roku

  def mount(_params, _, socket) do
    {:ok, socket}
  end

  def handle_event("up_volume", %{"value" => ""} = _param, socket), do: {:noreply, socket}
  def handle_event("up_volume", %{"value" => volume} = _param, socket) do

    Roku.up_volume(String.to_integer(volume))

    {:noreply, socket}
  end
  def handle_event("down_volume", %{"value" => ""} = _param, socket), do: {:noreply, socket}
  def handle_event("down_volume", %{"value" => volume} = _param, socket) do

    Roku.down_volume(String.to_integer(volume))

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
        <div class="w-screen h-screen flex flex-row flex-wrap">
          <div class="card w-40 h-32 mt-4 ml-4  bg-base-100 shadow-xl">
            <h2 class="text-center text-base font-light">Aumentar Volume</h2>
            <input type="number" min="0" max="100"
              class="w-32 input ml-auto mt-4 mr-auto bg-base-100 shadow-xl " phx-blur="up_volume" />
          </div>
          <div class="card w-40 h-32 mt-4 ml-4  bg-base-100 shadow-xl">
            <h2 class="text-center text-base font-light">Diminuir Volume</h2>
            <input type="number" min="0" max="100"
              class="w-32 input ml-auto mt-4 mr-auto bg-base-100 shadow-xl " phx-blur="down_volume" />
          </div>
          <h2>HOME</h2>
          <h2></h2>

        </div>
    """
  end

#  defp open_app_card(assigns) do
#    ~H"""
#      <div class="card w-96 bg-base-100 shadow-xl">

#      <figure><img src="http://192.168.0.10:8060/query/icon/12" alt="Girl in a jacket" width="500" height="600"></figure>
#      <div class="card-body">
#        <h2 class="card-title">Shoes!</h2>
#        <p>If a dog chews shoes whose shoes does he choose?</p>
#        <div class="card-actions justify-end">
#          <button class="btn btn-primary">Buy Now</button>
#        </div>
#      </div>
#    </div>
#"""
#  end


end
