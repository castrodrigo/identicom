defmodule Identicon do
  @moduledoc """
    Generates a Identicon type of Avatar based in a String input.
    Each String will always generate the same shaped image.
  """

  @doc """
    Process a String input and trough a series of helpers generats a unique image for that entry.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save(input)
  end

  @doc """
    Generates binary into list data based on the MD5 of the String input.
    Returns %Identicon.Image struct.
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  @doc """
    Extract three first entries in the list and use them to have RGB color.
    Returns %Identicon.Image struct.
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
    Breaks the 16 list into groups of 3 and iterate building the rows of the grid.
    Returns %Identicon.Image struct.
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  @doc """
    Helper that transpose a copy of 1st and 2nd items of the list to 4th and 5th.
  """
  def mirrow_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  @doc """
    Detects odd entries in the list and filter them, keeping the even as indexes to fill.
    Returns %Identicon.Image struct.
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    filtered = Enum.filter(grid, fn {code, _index} -> rem(code, 2) == 0 end)

    %Identicon.Image{image | grid: filtered}
  end

  @doc """
    Detects x, y axis points of each rectangle to draw image.
    Returns %Identicon.Image struct.
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        x_axys = rem(index, 5) * 50
        y_axys = div(index, 5) * 50

        top_left = {x_axys, y_axys}
        bottom_right = {x_axys + 50, y_axys + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
    Uses :egd to initialize image in memory and draws each retangle by coords.
    Returns :egd rendered image
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    canvas = :egd.create(250, 250)
    fill = :egd.color(canvas, color)

    Enum.each(pixel_map, fn {top_left, bottom_right} ->
      :egd.filledRectangle(canvas, top_left, bottom_right, fill)
    end)

    :egd.render(canvas)
  end

  @doc """
    Saves input to filesystem.
  """
  def save(image, input) do
    File.write!("#{input}_identicon.png", image)
  end
end
