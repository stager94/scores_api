module SofaScore
	module Football
		module Competitions
			class ImportFlag < SofaScore::Football::Base
				
				attr_accessor :competition_id

				def run!
					competition.update flag: sofa_score_flag
				end

			private

				def competition
					@_competition ||= Competition.find competition_id
				end

				def sofa_score_flag
					open("http://www.sofascore.com/u-tournament/#{competition.sofa_score_id}/logo")
				end

				def valid?
					raise SofaScore::Errors::ParamNotDefine unless competition_id
				end

			end
		end
	end
end
