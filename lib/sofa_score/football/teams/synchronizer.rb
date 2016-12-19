module SofaScore
	module Football
		module Teams
			class Synchronizer < SofaScore::Football::Base

				LINKS_SELECTOR = ".standings-table .cell--standings .cell__section--main a.js-link"

				attr_reader :competition_id

				def run!
					goto build_url

					waiting while links.length == 0
					export!
				end

			private

				def competition
					@_competition ||= Competition.includes(:region).find(competition_id)
				end

				def region
					@_region ||= competition.region
				end

				def build_url
					[BASE_URL_HTML[:en], "tournament", "football", region.sofa_score_slug, competition.sofa_score_slug, competition.sofa_score_id].join "/"
				end

				def links
					doc.css LINKS_SELECTOR
				end

				def valid?
					raise SofaScore::Errors::ParamNotDefine unless competition_id
				end

				def export!
					links.each do |link|
						team = Team.where(sofa_score_id: prepare_params(link)[:sofa_score_id]).first_or_initialize
						team.update prepare_params(link)
					end
				end

				def prepare_params(node)
					sofa_score_id = node.attributes["href"].value.split("/")[-1]
					{
						title_en: get_html_node_text(node),
						sofa_score_id: sofa_score_id,
						sofa_score_slug: node.attributes["href"].value.split("/")[-2],
						logo: open("http://www.sofascore.com/images/team-logo/football_#{sofa_score_id}.png")
					}
				end

			end
		end
	end
end
