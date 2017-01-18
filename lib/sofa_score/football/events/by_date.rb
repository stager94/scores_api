module SofaScore
  module Football
    module Events
      class ByDate < SofaScore::Football::Base

        attr_reader :date, :lang


        LINKS_SELECTOR = ".event-list-main .js-event-list-tournament-header .cell__section--main"

        def initialize(params = {})
          super
          @lang = "en"
          refresh_locale
        end

        def execute
          goto url

          waiting while headers.length == 0 && @timer < 500
          export!
        end

        private

        def export!
          headers.each do |header|
            export header
          end
        end

        def headers
          doc.css LINKS_SELECTOR
        end

        def url
          "http://www.sofascore.com/football/#{date.strftime('%Y-%m-%d')}"
        end

        def export(header)
          competition_node = header.css(".cell__content:nth-child(2) a")[0]
          competition_id = competition_node.attr("href").split("/")[-1].to_i

          competition = region.competitions.find_by(sofa_score_id: competition_id)
          return unless competition

          Sync::Competitions::Events.perform_async competition.id
        end

      end
    end
  end
end
