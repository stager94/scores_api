ActiveAdmin.register Team do

	index do
		selectable_column
		id_column
		column :logo do |t|
			image_tag t.logo, size: "30x30"
		end
		column :title_en
		# column :full_title_en
		column :sofa_score_id
		column :sofa_score_slug
		actions
	end

end
