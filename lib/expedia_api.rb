module TripPlannerAPIs
  class ExpediaAPI
    require "httparty"

    def self.things_todo(destination, startDate, endDate)
      url = self.expedia_search_uri(destination, startDate, endDate)
      results = self.expedia_request(url)
      result = results["activities"]

      if result != nil
        i = 0
        array = []
          while i <= 10 do
            array.push(result[i])
            i += 1
          end
          return array
      end
    end

    # def self.limit(limit)
    #   i = 0
    #   array = []
    #   while i <= limit
    #     array[i].push(result[i])
    #     i ++
    #   end
    #   retun array
    # end

    private

      def self.expedia_request(url)
        results = HTTParty.get(url)
      end

      def self.expedia_search_uri(destination, startDate, endDate)
        "http://terminal2.expedia.com/x/activities/search?location=#{destination}&startDate=#{startDate}&endDate=#{endDate}" + self.expedia_cid
      end

      def self.expedia_cid
        "&apikey=#{ ENV["EXPEDIA_KEY"]}"
      end
  end
end
