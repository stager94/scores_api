namespace :import do
	LANGUAGES = %w(ru en de)

	task regions: :environment do
		LANGUAGES.each do |lang|
			p "START importing regions for #{lang} locale"
			SofaScore::Foorball::Regions::Synchronizer.new(lang: lang).run!
			p "FINISH importing regions for #{lang} locale"
		end
	end
end
