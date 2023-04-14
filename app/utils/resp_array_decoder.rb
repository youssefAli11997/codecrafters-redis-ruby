require_relative "resp_line_decoder"

module Utils
    class RespArrayDecoder
        def self.decode(client)
            line = client.gets("\r\n")
            return if line.nil?

            array_length = line[1..-3].to_i # "*1\r\n", ignoring * and \r\n
            array = []
            
            array_length.times do
                item = RespLineDecoder.decode_line(client)
                array << item
            end
        
            array
        end
    end
end