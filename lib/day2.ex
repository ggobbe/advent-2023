defmodule AdventOfCode.Day2 do
  alias AdventOfCode.InputReader

  @type set :: %{required(String.t()) => integer}
  @type game :: %{required(:sets) => [set], required(:number) => integer}

  def part1 do
    part1_max = %{"red" => 12, "green" => 13, "blue" => 14}

    answer =
      InputReader.read("day2.txt")
      |> String.split("\n")
      |> Enum.map(&parse_game/1)
      |> Enum.filter(&all_sets_lower_than?(&1, part1_max))
      |> Enum.map(fn game -> game.number end)
      |> Enum.sum()

    IO.inspect(answer)
  end

  @spec parse_game(String.t()) :: game
  defp parse_game(line) do
    [match | _] = Regex.scan(~r/Game (\d+): (.+)/, line)
    [_, game_number, sets_text] = match

    sets =
      sets_text
      |> String.split("; ")
      |> Enum.map(&parse_set/1)

    %{
      sets: sets,
      number: String.to_integer(game_number)
    }
  end

  @spec parse_set(String.t()) :: set
  defp parse_set(set_text) do
    set_text
    |> String.split(", ")
    |> Enum.map(fn color_text ->
      [quantity, color] = String.split(color_text, " ")
      {color, String.to_integer(quantity)}
    end)
    |> Enum.into(%{})
  end

  @spec all_sets_lower_than?(game, set) :: boolean
  defp all_sets_lower_than?(%{sets: sets}, max) do
    Enum.all?(sets, &set_lower_than?(&1, max))
  end

  @spec set_lower_than?(set, set) :: boolean
  defp set_lower_than?(set, max) do
    Enum.all?(set, fn {color, quantity} -> quantity <= max[color] end)
  end
end
