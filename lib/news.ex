defmodule News do
  @derive [Poison.Encoder]
  defstruct [:content, :guid, :title, :source]
end
