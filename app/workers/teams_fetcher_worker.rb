class TeamsFetcherWorker
  include Sidekiq::Worker

  def perform
    Competition.find_each do |c|
      TeamsForCompetitionWorker.perform_async c.id
    end
  end
end
