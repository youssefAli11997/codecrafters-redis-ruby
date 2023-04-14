require "socket"
require_relative "client_handler"

class YourRedisServer
  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new(@port)
    loop do
      Thread.start(server.accept) do |client|
        ClientHandler.handle(client)
      end
    end
  end
end

YourRedisServer.new(6379).start
