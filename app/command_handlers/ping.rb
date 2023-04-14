require_relative "../utils/resp_encoder"

module CommandHandlers
    class Ping
        include Utils
        
        def self.handle(client, command_array)
            case command_array.length
            when 1
                client.puts RespEncoder.encode('+PONG')
            when 2 # the second item is a message
                client.puts RespEncoder.encode("+#{command_array[1].gsub('\n', '\\n')}")
            else
                client.puts RespEncoder.encode("-wrong number of arguments for 'ping' command")
            end
        end
    end
end