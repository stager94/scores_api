module SofaScore
	module Football
		module Regions
			class Synchronizer < SofaScore::Football::Base

				attr_accessor :lang

				LINKS_SELECTOR = ".leagues ul.leagues__list a.leagues__link"

				def initialize(params = {})
					super
					refresh_locale
				end

				def run!
					goto BASE_URL_HTML[lang.to_sym]

					waiting while links.length == 0
					export!
					browser.close
				end

			private

				def valid?
					raise SofaScore::Errors::ParamNotDefine unless lang
				end

				def links
					doc.css LINKS_SELECTOR
				end

				def export!
					links.each do |link|
						region = sport.regions.where(sofa_score_id: get_html_node_attr(link, "data-id")).first_or_initialize
						region.update prepare_params(link)
					end
				end

				def prepare_params(node)
					{
						sofa_score_id: get_html_node_attr(node, "data-id"),
						sofa_score_slug: node.attributes["href"].value.split("/").last,
						:"title_#{lang}" => get_html_node_text(node.children[2])
					}
				end

			end
		end
	end
end
