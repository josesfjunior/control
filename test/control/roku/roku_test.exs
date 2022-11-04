defmodule Control.RokuTest do
  use ExUnit.Case

  alias Control.Roku
  require Logger

  describe "configure a roku volume" do
    test "up_volume/0" do
      volume = Roku.up_volume()
      assert volume == {:ok, "Sucess"}
    end

    test "up_volume/1" do
      volume = Roku.up_volume(5)
      assert volume == :ok
    end

    test "down_volume/0" do
      volume = Roku.down_volume()
      assert volume == {:ok, "Sucess"}
    end

    test "down_volume/1" do
      volume = Roku.down_volume(5)
      assert volume == :ok
    end

    test "mute_volume" do
      volume = Roku.mute_volume()
      assert volume == {:ok, "Sucess"}
    end
  end

  describe "testing a control buttons" do

    test "button home" do
      volume = Roku.home()
      assert volume == {:ok, "Sucess"}
    end

  end

  describe "open apps" do

    test "open netflix" do
     app =  Roku.launch_app("netflix")
     assert app == {:ok, "Sucess"}

    end

    test "open computador (hdmi 3)" do
      app =  Roku.launch_app("Computador")
      assert app == {:ok, "Sucess"}

    end


  end


end