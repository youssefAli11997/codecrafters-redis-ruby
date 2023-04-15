require_relative "../utils/resp_encoder"
require_relative "../data_store"

module CommandHandlers
    class Get
        include Utils
        
        def self.handle(client, command_array)
            case command_array.length
            when 2
                value = DataStore.get(command_array[1])
                if value.nil?
                    client.puts RespEncoder.encode('$-1')
                else
                    client.puts RespEncoder.encode("+#{value}")
                end
            else
                client.puts RespEncoder.encode("-wrong number of arguments for 'get' command")
            end
        end
    end
end