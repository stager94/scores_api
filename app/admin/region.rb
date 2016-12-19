ActiveAdmin.register Region do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	index do
		selectable_column
		id_column
		column :icon do |r|
			"<span class='flags flags-category flags--sm flags--#{r.sofa_score_slug}'></span>".html_safe
		end
		column :sport
		column :title
		# column :title_en
		# column :title_de
		# column :sofa_score_id
		column :sofa_score_slug
		column :competitions_count
		actions
	end


end
