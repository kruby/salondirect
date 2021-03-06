class AttachmentsController < ApplicationController
  # GET /attachments
  # GET /attachments.xml
  
  before_filter :current_controller #Findes i application_controller.rb
  before_filter :logged_in_as_admin?
  #before_filter :logged_in_as_user? #Findes i application_controller.rb
  
  # def index
  #   @attachments = Attachment.find(:all)
  #   
  #      respond_to do |format|
  #        format.html # index.html.erb
  #        format.xml  { render :xml => @attachments }
  #      end
  # end
  
  def index
    if params[:post_id]
      @attachment = find_attachment
      @attachments = @attachment.attachments
    else
      @attachments = Attachment.find(:all)
    end
        
  end
    
  # GET /attachments/1
  # GET /attachments/1.xml
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/new
  # GET /attachments/new.xml
  def new
    @attachment = Attachment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
  end

  # POST /attachments
  # POST /attachments.xml
  def create
    @attachment = Attachment.new(params[:attachment])

    respond_to do |format|
      if @attachment.save
        flash[:notice] = 'Attachment was successfully created.'
        format.html { redirect_to(@attachment) }
        format.xml  { render :xml => @attachment, :status => :created, :location => @attachment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.xml
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        flash[:notice] = 'Attachment was successfully updated.'
        format.html { redirect_to(@attachment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.xml
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to(attachments_url) }
      format.xml  { head :ok }
    end
  end
  
  def destroy_from_post
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    #redirect_to (:controller => 'post', :id => params[:post_id], :action => 'edit' )
    redirect_to edit_post_path(params[:post_id])
  end
  
  
  private

  def find_attachment
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  
  
end
