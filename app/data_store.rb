class DataStore
    HASH = {}

    def self.set(key, value)
        HASH[key] = value
        true
    end

    def self.get(key)
        HASH[key]
    end
end