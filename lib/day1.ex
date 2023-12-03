defmodule AdventOfCode.Day1 do
  alias AdventOfCode.InputReader

  # Replace with number but keep first and last letters
  # to support "merged" numbers, e.g. `twone` -> t2o1ne -> 21
  @text_numbers %{
    "one" => "o1e",
    "two" => "t2o",
    "three" => "t3e",
    "four" => "f4r",
    "five" => "f5e",
    "six" => "s6x",
    "seven" => "s7n",
    "eight" => "e8t",
    "nine" => "n9e"
  }

  def part1 do
    answer =
      InputReader.read("day1.txt")
      |> String.split("\n")
      |> Enum.map(&extract_number/1)
      |> Enum.sum()

    IO.inspect(answer)
  end

  def part2 do
    answer =
      InputReader.read("day1.txt")
      |> String.split("\n")
      |> Enum.map(&replace_text_numbers/1)
      |> Enum.map(&extract_number/1)
      |> Enum.sum()

    IO.inspect(answer)
  end

  defp extract_number(line) do
    numbers = Regex.scan(~r/\d/, line) |> List.flatten()

    first = Enum.at(numbers, 0)
    last = Enum.at(numbers, -1)

    String.to_integer(first <> last)
  end

  defp replace_text_numbers(line) do
    Enum.reduce(@text_numbers, line, fn {text, number}, acc ->
      String.replace(acc, text, number)
    end)
  end
end
