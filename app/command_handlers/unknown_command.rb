require_relative "../utils/resp_encoder"

module CommandHandlers
    class UnknownCommand
        include Utils
        
        def self.handle(client, command_array)
            client.puts RespEncoder.encode("-unknown command '#{command_array.first}'")
        end
    end
end