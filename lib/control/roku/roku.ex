defmodule Control.Roku do

  alias XmlToMap
  require Logger

  def up_volume() do
    keypress_request("VolumeUp")
    |> response
  end

  def up_volume(volume) do
    volume
    |> case  do
     0  -> :ok
     _ -> up_volume(); up_volume(volume - 1)
    end
  end

  def down_volume() do
    keypress_request("VolumeDown")
    |> response()
  end

  def down_volume(volume) do
    volume
    |> case  do
         0  -> :ok
         _ -> down_volume(); down_volume(volume - 1)
       end
  end

  def mute_volume() do
    keypress_request("VolumeMute")
    |> response()
  end

  def home() do
    #InputHDMI2
    keypress_request("Home")
    |> response()
  end

  def launch_app(app) do
    apps = query_apps_request()
    |> XmlToMap.naive_map()

    %{"apps" => %{"app" => list_of_maps} = _} = apps
    select_app = select_specific_app(list_of_maps, app)

    launch_app_request(select_app.id)
    |> response()
  end

  def get_tv_icon(app) do
    apps = query_apps_request()
           |> XmlToMap.naive_map()

    %{"apps" => %{"app" => list_of_maps} = _} = apps
    select_app = select_specific_app(list_of_maps, app)
    get_icon(select_app.id)
  end

  defp get_roku_url(), do: Application.get_env(:control, :roku_url)
  defp keypress_request(action), do: HTTPoison.post!("#{get_roku_url()}keypress/#{action}", "")
  defp query_apps_request(), do: HTTPoison.get!("#{get_roku_url()}query/apps").body
  defp launch_app_request(id), do: HTTPoison.post!("#{get_roku_url()}launch/#{id}", "")
  defp get_icon(id), do: HTTPoison.get!("#{get_roku_url()}query/icon/#{id}").body
  defp response(%{status_code: 200} = _response), do: {:ok, "Sucess"}
  defp response(%{status_code: code} = _response), do: {:bad_request, code}
  defp select_specific_app(list_of_maps, app) do
    specific_app = list_of_maps
    |> Enum.map(fn %{"#content" => value, "-id" => id} -> %{value: value, id: id} end)
    |> Enum.filter(fn %{value: value} -> String.upcase(value) == String.upcase(app) end)
    [map_app] = specific_app
    map_app
  end


end