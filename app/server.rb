require "socket"

class YourRedisServer
  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new(@port)

    loop do
      Thread.start(server.accept) do |client|
        request = client.gets
        puts request
        commands = request.split '\n'
        puts commands
        commands.each do |command|
          client.puts handle_command(command)
        end
        client.close
      end
    end
  end

  private
  
  def handle_command(command)
    if command == 'ping' || command == 'PING'
      "+PONG\r"
    end
    "- ERR unknown command"
  end
end

YourRedisServer.new(6379).start
