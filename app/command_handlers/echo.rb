require_relative "../utils/resp_encoder"

module CommandHandlers
    class Echo
        include Utils
        
        def self.handle(client, command_array)
            case command_array.length
            when 2 # the second item is a message
                client.puts RespEncoder.encode("+#{command_array[1].gsub('\n', '\\n')}")
            else
                client.puts RespEncoder.encode("-wrong number of arguments for 'echo' command")
            end
        end
    end
end