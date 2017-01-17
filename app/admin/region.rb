ActiveAdmin.register Region do

	member_action :sync_competitions, method: :post do
    Sync::Regions::Competitions.perform_async params[:id]
    redirect_to :back, notice: 'Job was queued succesfully!'
  end

  action_item only: :show do
    link_to 'Sync competitions', sync_competitions_admin_region_path(resource), method: :post
  end

	index do
		selectable_column
		id_column
		column :icon do |r|
			"<span class='flags flags-category flags--sm flags--#{r.sofa_score_slug}'></span>".html_safe
		end
		column :sport
		column :title
		column :sofa_score_slug
		column :competitions_count
		actions
	end


end
