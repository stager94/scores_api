module SofaScore
	module Football
		module Teams
			class ExtendedInfo < SofaScore::Football::BaseSimple

				attr_reader :team_id

				def run!
					goto build_url
					export!
				end

			private

				def team
					@_team ||= Team.find team_id
				end

				def build_url
					[BASE_URL_HTML[:en], "team", "football", team.sofa_score_slug, team.sofa_score_id].join "/"
				end

				def export!
					team.update full_title_ru: get_html_node_text(title),
											full_title_en: get_html_node_text(title),
											full_title_de: get_html_node_text(title)
				end

				def prepare_params
					{
						full_title_en: get_html_node_text(title)
					}
				end

				def title
					doc.css(".cell__section--main h2.page-title")
				end

			end
		end
	end
end
