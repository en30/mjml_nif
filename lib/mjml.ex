defmodule Mjml do
  @moduledoc """
  Provides functions for transpiling MJML email templates to HTML.
  """

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :mjml,
    crate: "mjml_nif",
    base_url: "https://github.com/en30/mjml_nif/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_PRECOMPILATION_EXAMPLE_BUILD") in ["1", "true"],
    version: version

  @doc """
  Converts an MJML string to HTML content.

  (Passing any options – which the underlying mrml Rust crate already handles – is not yet implemented.)

  Returns a result tuple:
  - `{:ok, html}` for a successful MJML transpiling
  - `{:error, message}` for a failed MJML transpiling

  ## Examples

      iex> Mjml.to_html("<mjml><mj-head></mj-head></mjml>")
      {:ok, "<!doctype html><html xmlns=..."}

      iex> Mjml.to_html("something not MJML")
      {:error, "Couldn't convert MJML template"}

  """
  def to_html(_mjml), do: error()

  defp error(), do: :erlang.nif_error(:nif_not_loaded)
end
