module SofaScore
	module Football
		module Competitions
			class Synchronizer < SofaScore::Football::Base

				attr_accessor :lang, :region_id

				LINKS_SELECTOR = ".event-list-main > a.js-link"

				def initialize(params = {})
					super
					refresh_locale
				end

				def run!
					goto build_url

					waiting while links.length == 0 && @timer < 500
					export!
					browser.close
				end

			private

				def region
					@_region ||= Region.find region_id
				end

				def build_url
					[BASE_URL_HTML[:en], "football", region.sofa_score_slug].join("/")
				end

				def valid?
					raise SofaScore::Errors::ParamNotDefine if !lang || !region_id
				end

				def links
					doc.css LINKS_SELECTOR
				end

				def export!
					links.each do |link|
						competition = region.competitions.where(sofa_score_id: prepare_params(link)[:sofa_score_id]).first_or_initialize
						competition.update prepare_params(link)
					end
				end

				def prepare_params(node)
					sofa_score_id = node.attributes["href"].value.split("/")[-1]
					{
						sofa_score_id: sofa_score_id,
						sofa_score_slug: node.attributes["href"].value.split("/")[-2],
						:"title_#{lang}" => get_html_node_text(node),
						flag: open("http://www.sofascore.com/u-tournament/#{sofa_score_id}/logo")
					}
				end

			end
		end
	end
end
