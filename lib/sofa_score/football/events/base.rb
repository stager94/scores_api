module SofaScore
  module Football
    module Events
      class Base

        private

        def find_status
          EventStatus.find_by_code(params["status"]["code"])
        end

        def create_status
          EventStatus.create code: params["status"]["code"],
                             type: params["status"]["type"],
                             description: params["status"]["description"]
        end

      end
    end
  end
end
