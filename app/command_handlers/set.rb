require_relative "../utils/resp_encoder"
require_relative "../data_store"

module CommandHandlers
    class Set
        include Utils
        
        def self.handle(client, command_array)
            case command_array.length
            when 3
                handle_normal_set(client, command_array[1], command_array[2])
            when 5
                if command_array[3].upcase == 'PX'
                    handle_expiry_set(client, command_array[1], command_array[2], command_array[4])
                else
                    client.puts RespEncoder.encode("-syntax error")
                end
            else
                client.puts RespEncoder.encode("-wrong number of arguments for 'set' command")
            end
        end

        private

        def self.handle_normal_set(client, key, value)
            if DataStore.set(key, value) == true
                client.puts RespEncoder.encode('+OK')
            else
                client.puts RespEncoder.encode('$-1')
            end
        end

        def self.handle_expiry_set(client, key, value, expiry_after_milliseconds)
            expiry_after_milliseconds = expiry_after_milliseconds.to_i
            if expiry_after_milliseconds < 0
                client.puts RespEncoder.encode('-expiration time cannot be negative')
            elsif DataStore.set(key, value, expiry_after_milliseconds: expiry_after_milliseconds) == true
                client.puts RespEncoder.encode('+OK')
            else
                client.puts RespEncoder.encode('$-1')
            end
        end
    end
end