require "socket"

class YourRedisServer
  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new(@port)
    loop do
      client = server.accept
      handle_client(client)
    end
  end

  private

  def handle_client(client)
    loop do
      command_array = read_resp_array(client)
      handle_command_array(client, command_array)
    end
  end

  def read_resp_array(client)
    array_length = client.gets[1..-3].to_i # "*1\r\n", ignoring * and \r\n
    array = []
    
    array_length.times do
      item = parse_line(client)
      array << item
    end

    array
  end

  def parse_line(client)
    line = client.gets
    type = line[0]
    data = line[1..-3]

    case type
    when '$'
      # data is a bulk string length in this case
      client.gets[0..-3] # read the bulk string itself from the next line
    when '+'
      # data is a simple string
      data
    when ':'
      # data is an integer
      data.to_i
    when '*'
      # data is an array
      # I may handle it later if there is a need
    end
  end

  def handle_command_array(client, command_array)
    command = command_array.first.upcase

    case command
    when 'PING'
      client.puts resp_encode('+PONG')
    else
      client.puts resp_encode("-ERR unknown command #{command}")
    end
  end

  def resp_encode(message)
    "#{message}\r\n"
  end
end

YourRedisServer.new(6379).start
