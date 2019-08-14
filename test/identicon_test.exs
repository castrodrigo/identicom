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

  test "mirror_row should tanspose a copy of idxs 1,2 to idxs 5,4" do
    list_row = [1, 2, 3]

    assert Identicon.mirrow_row(list_row) == [1, 2, 3, 2, 1]
  end
  end
end
