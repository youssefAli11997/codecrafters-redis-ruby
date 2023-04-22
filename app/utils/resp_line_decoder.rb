module Utils
    class RespLineDecoder
        def self.decode_line(client)
            line = client.gets("\r\n")
            type = line[0]
            data = line[1..-3]
        
            case type
            when '$'
                # data is a bulk string length in this case
                client.gets("\r\n")[0..-3] # read the bulk string itself from the next line
            when '+'
                # data is a simple string
                data
            when ':'
                # data is an integer
                data.to_i
            when '*'
                # data is an array
                # I may handle it later if there is a need to
            end
        end
    end
end