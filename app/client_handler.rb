require_relative "command_handlers/ping"
require_relative "command_handlers/echo"
require_relative "command_handlers/unknown_command"
require_relative "utils/resp_array_decoder"

class ClientHandler
    include CommandHandlers
    include Utils

    def self.handle(client)
        loop do
            command_array = RespArrayDecoder.decode(client)
            break if command_array.nil?
            handle_command_array(client, command_array)
        end
    end

    private

    def self.handle_command_array(client, command_array)
        command = command_array.first.upcase
    
        case command
        when 'PING'
            Ping.handle(client, command_array)
        when 'ECHO'
            Echo.handle(client, command_array)
        else
            UnknownCommand.handle(client, command_array)
        end
    end
end