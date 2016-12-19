module SofaScore
	module Errors
		class ParamNotDefine < StandardError
			def initialize(msg = "missing required param")
				super
			end
		end
	end
end
