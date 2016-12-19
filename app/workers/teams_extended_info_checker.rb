class TeamsExtendedInfoChecker
  include Sidekiq::Worker

  def perform
    Team.where(full_title_en: nil).find_each {|team| TeamExtendedInfoWorker.perform_async(team.id) }
  end
end
