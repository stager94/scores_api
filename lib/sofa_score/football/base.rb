require 'watir'

module SofaScore
	module Football
		class Base

			include Constants

			def initialize(params = {})
				params.each {|k, v| instance_variable_set "@#{k}", v }
				@timer = 0
				valid?
			end

		private

			def html
				browser.html
			end

			def doc
				Nokogiri::HTML html
			end

			def browser
				@_browser ||= Watir::Browser.new :phantomjs
			end

			def goto(url, delay = 0)
				browser.goto url if url
				sleep delay if delay > 0
			end

			def waiting(message = "Waiting..")
				@timer += 1
				p message
			end

			def get_html_node_attr(node, attr_name)
				node.attributes[attr_name].value
			end

			def get_html_node_text(node)
				node.text.strip.gsub("\n", "")
			end

			def refresh_locale
				browser.goto BASE_URL_HTML[lang.to_sym]
				browser.link(data_locale: lang, class: "footer__link").click
			end

			def valid?
				true
			end

			def sport
				@_sport ||= Sport.find_by_sofa_score_slug("football")
			end

		end
	end
end
