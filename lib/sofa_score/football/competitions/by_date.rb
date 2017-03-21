module SofaScore
  module Football
    module Competitions
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
          browser.close
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
          region_node      = header.css(".cell__content:nth-child(1) a")[0]
          competition_node = header.css(".cell__content:nth-child(2) a")[0]

          region_slug = region_node.attr("href").split("/")[-2]
          region = Region.find_by(sofa_score_slug: region_slug)
          region ||= Region.create sofa_score_slug: region_slug,
                                   title_en: get_html_node_text(region_node),
                                   sport_id: 1


          competition_slug = competition_node.attr("href").split("/")[-2]
          competition_id = competition_node.attr("href").split("/")[-1].to_i
          competition_title = get_html_node_text(competition_node).split(",")[0]

          competition = region.competitions.find_by(sofa_score_id: competition_id)
          competition ||= region.competitions.create sofa_score_slug: competition_slug,
                                                     sofa_score_id: competition_id,
                                                     title_en: competition_title,
                                                     flag: open("http://www.sofascore.com/u-tournament/#{competition_id}/logo")
        end

      end
    end
  end
end
