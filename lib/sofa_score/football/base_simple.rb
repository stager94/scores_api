require 'watir'

module SofaScore
  module Football
    class BaseSimple < SofaScore::Football::Base

    private

      def html
        @html
      end

      def doc
        @_doc ||= Nokogiri::HTML html
      end

      def goto(url, delay = 0)
        @html = open url
      end

      def refresh_locale
        browser.goto BASE_URL_HTML[lang.to_sym]
        browser.link(data_locale: lang, class: "footer__link").click
      end

    end
  end
end
