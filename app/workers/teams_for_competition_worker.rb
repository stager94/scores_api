class TeamsForCompetitionWorker
  include Sidekiq::Worker

  def perform(competition_id)
    SofaScore::Football::Teams::Synchronizer.new(competition_id: competition_id).run!
  end
end
