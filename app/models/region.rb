class Region < ActiveRecord::Base

	translates :title

	has_many :competitions
	belongs_to :sport, counter_cache: true

	def import_competitions!
		SofaScore::Football::Competitions::Synchronizer.new(lang: "ru", region_id: self.id).run!
	end

end
