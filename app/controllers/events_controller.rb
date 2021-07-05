class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index]
  
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /events or /events.json
  def index

    @events=Event.all
    if params[:event_name]
      @event_name = params[:event_name]
      @events = @events.eventname(@event_name)
    end

    if params[:event_description]
      @event_description = params[:event_description]
      @events = @events.eventdescription(@event_description)
    end

    if params[:city]
      @city = params[:city]
      @events = @events.city(@city)
    end


    @events=@events.startdate(params[:start_date]) if params[:start_date].present?
    @events=@events.enddate(params[:end_date]) if params[:end_date].present?

    if params[:search]
      @search_term = params[:search]
      @events = @events.search_by(@search_term)



    end



  end



  # GET /events/1 or /events/1.json
  def show
    @events = Event.find(params[:id])
    @comment = Comment.new
    @comments = @event.comments

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Event PDF",
               template: "events/show.html.erb",
               layout: 'pdf.html'

      end
    end



  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)


    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    if current_user != @event.user and !current_user.admin?
    @event = current_user.events.find_by(id: params[:id])
    redirect_to events_path, notice: "Not Authorized" if @event.nil?
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_name, :event_description, :start_date, :end_date, :city, :latitude, :longitude, :image, :remove_image, :image_cache, :street_address,:city1,:state,:country,:zip_code)
    end
end
