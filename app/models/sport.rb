class Sport < ActiveRecord::Base

	translates :title

	has_many :regions
	has_many :competitions, through: :regions
end
