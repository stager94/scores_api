ActiveAdmin.register Event do

  member_action :get_info, method: :post do
    Sync::Events::Info.perform_async params[:id]
    redirect_to :back, notice: 'Job was queued succesfully!'
  end

  action_item only: :show do
    link_to 'Sync info', get_info_admin_event_path(resource), method: :post
  end

  filter :name
  filter :competition, as: :select
  filter :status_is_finished_eq, as: :boolean
  filter :status_in_interrupted_eq, as: :boolean
  filter :status_in_process_eq, as: :boolean

  scope :today

  # scope :finished
  # scope :not_finished
  # scope :live

  index do
    selectable_column
    id_column
    column :state do |e|
      if e.status.in_process?
        status_tag e.status.type, :remove
      elsif e.status.is_interrupted?
        status_tag e.status.type, :no
      elsif e.status.is_finished?
        status_tag e.status.type, :yes
      else
        status_tag e.status.type
      end
    end
    column :name
    column :started_at
    column :score do |e|
      e.draw_full_score
    end
    actions
  end

  show do |event|
    attributes_table do
      row :id
      row :name
      row :home_score
      row :away_score
      row :home_scores
      row :away_scores
      row :home_team
      row :away_team
    end
  end

  sidebar :info, only: :show do
    attributes_table do
      row :venue
      row :referee
      row :season
      row :competition
      row :external_id
    end
  end

  sidebar :incidents, only: :show do
    render 'incidents', event: event
  end

end
