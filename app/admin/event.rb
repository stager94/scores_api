ActiveAdmin.register Event do

  member_action :get_info, method: :post do
    Sync::Events::Info.perform_async params[:id]
    redirect_to :back, notice: 'Job was queued succesfully!'
  end

  member_action :send_webhooks, method: :post do
    ScoresApi::WebHooks::Send.new(Event.find(params[:id])).execute
    redirect_to :back, notice: 'WebHooks was sended succesfully!'
  end

  action_item only: :show do
    link_to 'Sync info', get_info_admin_event_path(resource), method: :post
  end

  action_item only: :show do
    link_to 'Send Webhook', send_webhooks_admin_event_path(resource), method: :post
  end

  collection_action :sync_by_date, method: :post do
    SofaScore::Football::Competitions::ByDate.new(date: params[:data]).execute
    redirect_to collection_path, notice: "Синхронизация инициализирована"
  end

  sidebar :by_date, partial: "by_date"

  filter :id
  filter :name
  filter :competition, as: :select
  filter :status_is_finished_eq, as: :boolean
  filter :status_is_interrupted_eq, as: :boolean
  filter :status_in_process_eq, as: :boolean

  scope :today
  scope :live
  scope :only_score
  scope :not_started
  scope :without_integration

  index do
    selectable_column
    id_column
    column :state do |e|
      if e.status.in_process?
        status_tag e.status.key.humanize, :error
      elsif e.status.is_interrupted?
        status_tag e.status.type, :no
      elsif e.status.is_finished?
        status_tag e.status.type, :yes
      else
        status_tag e.status.type
      end
    end
    column :name
    column :competition
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
      row :protocol
      row :status do |e|
        if e.status.in_process?
          status_tag e.status.key.humanize, :error
        elsif e.status.is_interrupted?
          status_tag e.status.type, :no
        elsif e.status.is_finished?
          status_tag e.status.type, :yes
        else
          status_tag e.status.type
        end
      end
      row :created_at
    end
  end

  sidebar :info, only: :show do
    attributes_table do
      row :status
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
