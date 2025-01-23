module Serializers
  module EventRegistry
    class Location
      def self.serialize(locations)
        locations.map do |location|
          {
            "locationUri": "http://en.wikipedia.org/wiki/#{location.name}"
          }
        end
      end
    end
  end
end
