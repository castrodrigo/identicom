defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "hash_input always returns the same list with 16 items for each String" do
    input = "This is a test"
    %Identicon.Image{hex: hex} = Identicon.hash_input(input)

    assert length(hex) == 16

    %Identicon.Image{hex: hex2} = Identicon.hash_input(input)

    assert hex == hex2
  end
  end
end
