module SofaScore
  module Football
    module Events
      class AllByDate < SofaScore::Football::BaseSimple

        attr_reader :date, :lang, :region_slug

        def initialize(params = {})
          super
          @lang = "en"
          # refresh_locale
        end

        def execute
          tournaments = []
          if json["sportItem"] != []
            json["sportItem"]["tournaments"].each do |tournament|
              SofaScore::Football::Competitions::ProcessEvents.new(tournament, region_slug).execute
            end
          end
        end

        private

        def build_url
          [BASE_URL_HTML[:en], "football", region_slug, formatted_date, 'json'].join "/"
        end

        def formatted_date
          date.strftime "%Y-%m-%d"
        end

        def json
          @_json ||= JSON.parse Net::HTTP.get_response(URI.parse(build_url)).body
        end

      end
    end
  end
end

# SofaScore::Football::Events::AllByDate.new(date: Date.today, region_slug: 'australia').execute
