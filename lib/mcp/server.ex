defmodule MCP.Server do
  use GenServer
  import Plug.Conn

  @type schema_type() :: :object | :string | :array | :boolean | :number

  @type schema() :: %{
    optional(:items)      => schema(),
    optional(:properties) => %{atom() => schema()},
    optional(:required)   => list(atom()),
    type:                 schema_type(),
  }

  @type argument() :: %{
    name:         binary(),
    callback:     atom(),
    description:  binary(),
    required:     boolean()
  }

  @type prompt() :: %{
    name:         binary(),
    callback:     atom(),
    description:  binary(),
    arguments:    list(argument())
  }

  @type resource() :: %{
    uri:          binary(),
    name:         binary(),
    callback:     atom(),
    description:  binary(),
    mime_type:    binary()
  }

  @type tool() :: %{
    name:         binary(),
    description:  binary()
  }

  @callback init(opts :: any()) :: {:ok, state :: any()} | {:shutdown, reason :: any()}

  @callback handle_request(rpc :: map()) :: {:reply, response :: term()} | {:stop, reason :: any()}

  def handle_request(params) when is_map(params) do

  end

  def handle_request(%{assigns: %{server: server}} = conn, %{"id" => id} = params) when is_binary(id) do
    with  [{pid, _id}]      <- Registry.lookup(MCP.ServerRegistry, id),
          {:ok, response}   <- MCP.Server.call(pid, {:handle_request, params}) do

    end
  end
  def handle_request(%{assigns: %{server: server}} = conn, params) when is_map(params) do

  end
end
