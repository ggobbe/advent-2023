defmodule AdventOfCode.Day2 do
  alias AdventOfCode.InputReader

  @part1_bag %{"red" => 12, "green" => 13, "blue" => 14}

  def part1 do
    answer =
      InputReader.read("day2.txt")
      |> String.split("\n")
      |> Enum.map(&parse_game/1)
      |> Enum.filter(&all_sets_lower_than?(&1, @part1_bag))
      |> Enum.map(& &1.number)
      |> Enum.sum()

    # could be refactored to leverage get_smallest_set_possible/1 and compare it to @part1_bag
    # but I didn't come up with that function until doing part 2 ¯\_(ツ)_/¯
    IO.inspect(answer)
  end

  def part2 do
    answer =
      InputReader.read("day2.txt")
      |> String.split("\n")
      |> Enum.map(&parse_game/1)
      |> Enum.map(&get_smallest_set_possible/1)
      |> Enum.map(&power_set(&1))
      |> Enum.sum()

    IO.inspect(answer)
  end

  defp all_sets_lower_than?(%{sets: sets}, max), do: Enum.all?(sets, &set_lower_than?(&1, max))

  defp set_lower_than?(set, max),
    do: Enum.all?(set, fn {color, quantity} -> quantity <= max[color] end)

  defp get_smallest_set_possible(%{sets: sets}) do
    Enum.reduce(sets, %{}, fn set, mins ->
      Enum.reduce(set, mins, fn {color, quantity}, acc ->
        Map.put(acc, color, max(quantity, acc[color] || 0))
      end)
    end)
  end

  defp power_set(set), do: Enum.reduce(set, 1, fn {_, quantity}, acc -> acc * quantity end)

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

  defp parse_set(set_text) do
    String.split(set_text, ", ")
    |> Enum.map(fn color_text ->
      [quantity, color] = String.split(color_text, " ")
      {color, String.to_integer(quantity)}
    end)
    |> Enum.into(%{})
  end
end
