class EventsController < ApplicationController

	before_filter :find_event, :only => [:show, :edit, :update, :destroy]
	
	def index
		@events = Event.page(params[:page]).per(5)
		#@event = Event.page(params[:page]).per_page(10)
		#@event = @event.limit(10).page(params[:page])
		#@event = Kaminari.paginate_array(@event.first(10)).page(params[:page])
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
		#@event = Event.find(params[:id])
		flash[:notice] = "event was successfully updated"
		if @event.update_attributes(params[:event])
			redirect_to :action => :show, :id => @event
		else
			render :action => :edit
		end
	end
	
	def destroy
		flash[:alert] = "event was successfully deleted"
		@event.destroy

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
