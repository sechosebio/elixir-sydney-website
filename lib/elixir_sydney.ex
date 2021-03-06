defmodule ElixirSydney do
  use Application

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(ElixirSydney.Repo, []),
      # Start the endpoint when the application starts
      supervisor(ElixirSydney.Web.Endpoint, []),
      # Start your own worker by calling: ElixirSydney.Worker.start_link(arg1, arg2, arg3)
      # worker(ElixirSydney.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirSydney.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
    When used, dispatch to the appropriate controller/view/etc.
  """

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
