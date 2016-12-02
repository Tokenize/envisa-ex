defmodule EvlDaemon.CLI do
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _}
      -> :help

      {_, [host, password], _}
      -> {String.to_char_list(host), password}

      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: evl_daemon host password
    """

    System.halt(0)
  end

  def process({host, password}) do
    opts = %{hostname: host, password: password, event_dispatcher: nil}

    EvlDaemon.Supervisor.start_link(opts)

    Process.sleep(:infinity)
  end
end
