defmodule Mcp do
  require Phoenix.Router

  @doc """
  Defines an MCP server route.
  """
  defmacro mcp(path, server, options \\ []) do
    quote bind_quoted: binding() do
      Phoenix.Router.get(path, MCP.Server, :handle_request, Keyword.merge(options, [
        assigns: %{server: server}
      ]))
      Phoenix.Router.post(path, MCP.Server, :handle_request, Keyword.merge(options, [
        assigns: %{server: server}
      ]))
    end
  end
end
