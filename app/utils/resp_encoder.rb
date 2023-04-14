module Utils
    class RespEncoder
        def self.encode(message)
            "#{message}\r\n"
        end
    end
end