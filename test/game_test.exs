defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Player, Game}

  describe "start/2" do
    test "start the game state" do
      player = Player.build("luis", :chute, :soco, :cura)
      computer = Player.build("computer", :chute, :soco, :cura)
      assert {:ok, __pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("luis", :chute, :soco, :cura)
      computer = Player.build("computer", :chute, :soco, :cura)

      Game.start(computer, player)

      experted_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "luis"
        },
        status: :started,
        turn: :player
      }

      assert experted_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("luis", :chute, :soco, :cura)
      computer = Player.build("computer", :chute, :soco, :cura)

      Game.start(computer, player)

      experted_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "computer"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "luis"
        },
        status: :started,
        turn: :player
      }

      experted_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "computer"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "luis"
        },
        status: :continue,
        turn: :computer
      }

      Game.update(new_state)
      assert experted_response != Game.info()
    end
  end

end
