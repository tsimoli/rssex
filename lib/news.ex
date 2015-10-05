defmodule News do
  @derive [Poison.Encoder]
  defstruct [:content, :guid]
end
