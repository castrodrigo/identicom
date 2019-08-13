defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_tofill_squares
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def mirrow_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  def filter_tofill_squares(%Identicon.Image{grid: grid} = image) do
    filtered = Enum.filter(grid, fn {code, _index} -> rem(code, 2) == 0 end)

    %Identicon.Image{image | grid: filtered}
  end
end
