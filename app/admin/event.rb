ActiveAdmin.register Event do

  member_action :get_info, method: :post do
    Sync::Events::Info.perform_async params[:id]
    redirect_to :back, notice: 'Job was queued succesfully!'
  end

  action_item only: :show do
    link_to 'Sync info', get_info_admin_event_path(resource), method: :post
  end

  filter :competition, as: :select

  scope :today

  # scope :finished
  # scope :not_finished
  # scope :live

  index do
    selectable_column
    id_column
    column :name
    column :started_at
    column :score do |e|
      e.draw_full_score
    end
    actions
  end


end
