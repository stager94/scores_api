ActiveAdmin.register Sport do

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


	form do |f|
		f.inputs "General information" do
			f.input :title_ru
			f.input :title_en
			f.input :title_de
			f.input :sofa_score_id
			f.input :sofa_score_slug
		end

		actions
	end

end
