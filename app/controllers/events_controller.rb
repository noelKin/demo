class EventsController < ApplicationController

	before_filter :find_event, :only => [:show, :edit, :update, :destroy]
	
	
	def index
		@event = Event.page(params[:page]).per(10)
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		
		if @event.save
			flash[:notice] = "event was successfully created"
			redirect_to :action => :index
		else
			flash[:notice] = "failed to create"
			render :action => :show
		end
	end

	def show
		@page_title = @event.name
	end
	
	
	def edit
	end
	
	def update
		flash[:notice] = "event was successfully updated"
		if @event.update_attributes(event_params)
			redirect_to :action => :show, :id => @event
		else
			render :action => :edit
		end
	end
	
	def destroy
    @event = Event.find(params[:id])

    if @event.destroy
		  flash[:alert] = "event was successfully deleted"
    end

		redirect_to :action => :index
	end
	
	def to_key
		new_record? ? nil : [ self.send(self.class.primary_key) ]
	end

	def persisted?
		false
	end
	
	
	
	protected

	def find_event
		@event = Event.find(params[:id])
	end
	
	private
	
	def event_params
		params.require(:event).permit(:name, :description)
	end
end
