defmodule Identicon.Image do
  @moduledoc """
    Contains a Struct definition that is responsible for storing
    the main data of Identicon application, making available for processing
  """

  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end
