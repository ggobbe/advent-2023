defmodule AdventOfCode.InputReader do
  def read(day) do
    file_path = File.cwd!() <> "/inputs/#{day}.txt"

    case File.read(file_path) do
      {:ok, content} ->
        String.trim(content)

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
        ""
    end
  end
end
