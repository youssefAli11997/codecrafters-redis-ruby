class DataStore
    HASH = {}
    EXPIRY_AT = {}

    def self.set(key, value, expiry_after_milliseconds: nil)
        HASH[key] = value
        unless expiry_after_milliseconds.nil?
            EXPIRY_AT[key] = Time.now + (expiry_after_milliseconds / 1000)
        end
        true
    end

    def self.get(key)
        if EXPIRY_AT.key?(key) && EXPIRY_AT[key] < Time.now
            EXPIRY_AT.delete(key)
            HASH.delete(key)
            nil
        else
            HASH[key]
        end
    end
end