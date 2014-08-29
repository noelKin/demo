class EventsController < ApplicationController

	before_filter :find_event, :only => [ :show, :edit, :update, :destroy]
	
	def index
		@events = Event.all
		#@events = Event.page(params[:page]).per_page(10)
		#@events = @events.limit(10).page(params[:page])
		#@events = Kaminari.paginate_array(@events.first(10)).page(params[:page])
	end

	def new
		@events = Event.new
	end

	def create
		flash[:notice] = "event was successfully created"
		@events = Event.new(params[:events])

		if @events.save
			redirect_to :action => :index
		else
			render :action => :show
		end
	end

	def show
		@page_title = @events.name
	end
	
	
	def edit
		@events = Event.find(params[:id])
		return
	end
	
	def update
		#@events = Event.find(params[:id])
		flash[:notice] = "event was successfully updated"
		if @events.update_attributes(params[:event])
			redirect_to :action => :show, :id => @events
		else
			render :action => :edit
		end
	end
	
	def destroy
		flash[:alert] = "event was successfully deleted"
		@events.destroy

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
	

	
end
