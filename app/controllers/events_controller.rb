class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save

      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    if params[:search].blank?
      redirect_to events_path
    else
      @parameter = params[:search].downcase
      @results = Event.all.where("lower(event_name) LIKE :search", search: "%#{@parameter}%")
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_date, :event_location, :event_capacity, :event_name, :event_latitude, :event_longitude, :event_price, :photo)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
