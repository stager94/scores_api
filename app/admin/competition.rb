ActiveAdmin.register Competition do

	batch_action :sync_teams do |ids|
		ids.each {|i| TeamsForCompetitionWorker.perform_async(i) }
    redirect_to collection_path, alert: "Synchronization have been activated."
  end

  member_action :sync_events, method: :post do
    Sync::Competitions::Events.perform_async params[:id]
    redirect_to :back, notice: 'Job was queued succesfully!'
  end

  action_item only: :show do
    link_to 'Sync events', sync_events_admin_competition_path(resource), method: :post
  end

	index do
		selectable_column
		id_column
		column :sport
		column :region
		column :title do |c|
			"#{image_tag c.flag, size: "32x32", class: 'middle'} #{c.title}".html_safe
		end
		column :active_season do |c|
			link_to c.seasons.active.try(:name), admin_season_path(c.seasons.active) if c.seasons.active.present?
		end
		# column :sofa_score_id
		# column :sofa_score_slug
		actions
	end

end
