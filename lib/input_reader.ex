defmodule AdventOfCode.InputReader do
  def read(file) do
    file_path = File.cwd!() <> "/inputs/#{file}"

    case File.read(file_path) do
      {:ok, content} ->
        String.trim(content)

      {:error, reason} ->
        IO.puts("Error reading file: #{reason}")
        ""
    end
  end
end
