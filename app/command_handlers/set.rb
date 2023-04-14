require_relative "../utils/resp_encoder"
require_relative "../data_store"

module CommandHandlers
    class Set
        include Utils
        
        def self.handle(client, command_array)
            case command_array.length
            when 3
                if DataStore.set(command_array[1], command_array[2]) == true
                    client.puts RespEncoder.encode('+OK')
                else
                    client.puts RespEncoder.encode('$-1')
                end
            else
                client.puts RespEncoder.encode("-wrong number of arguments for 'set' command")
            end
        end
    end
end