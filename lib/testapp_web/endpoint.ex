defmodule TestappWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :testapp

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_testapp_key",
    signing_salt: "lp3ArIgE",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :testapp,
    gzip: false,
    only: TestappWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :testapp
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug :secret_plug, code: "secretparam1", exp: "01-01-2026"
  plug TestappWeb.Router

  @doc """
  this plug is used to check secret access via url params (yes, very secure)
  """
  def secret_plug(%Plug.Conn{:params => %{"secret" => opts[:code]}} = conn, opts) do
    assign(conn, :secret_access, true)
  end

  def secret_plug(%Plug.Conn{} = conn, _opts) do
    assign(conn, :secret_access, false)
  end
end
