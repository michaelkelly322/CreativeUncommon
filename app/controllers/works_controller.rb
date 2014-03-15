class WorksController < ApplicationController
  include LengthHelper
  before_action :set_work, only: [:show, :edit, :update, :destroy, :topdf]
  before_action :set_works, only: [:index]

  # GET /works
  # GET /works.json
  def index
    
  end

  def search
    conditions = Array.new
    arguments = Hash.new
    
    if !params[:id].nil?
      unless params[:id].blank?
        conditions << 'user_id = :id'
        arguments[:id] = params[:id]
      end
    end
    
    if !params[:work].nil? && !params[:work][:title].nil?
      unless params[:work][:title].blank?
        conditions << 'title LIKE :title'
        arguments[:title] = "%#{params[:work][:title]}"
      end
    end
    
    if !params[:work].nil? && !params[:work][:author].nil?
      unless params[:work][:author].blank?
        conditions << 'author_name LIKE :author'
        arguments[:author] = "%#{params[:work][:author]}"
      end
    end
    
    if !params[:work].nil? && !params[:work][:genre].nil?
      unless params[:work][:genre].blank?
        conditions << 'genre LIKE :genre'
        arguments[:genre] = "%#{params[:work][:genre]}"
      end
    end
    
    if !params[:work].nil? && !params[:work][:length].nil?
      unless params[:work][:length].blank?
        conditions << 'word_count >= :min AND word_count <= :max'
        arguments[:min] = get_length_min(params[:work][:length])
        arguments[:max] = get_length_max(params[:work][:length])
      end
    end
    
    conditions << 'draft = :draft'
    arguments[:draft] = false
    
    conditions << 'approved = :approved'
    arguments[:approved] = true
    
    all_conditions = conditions.join(' AND ')
    
    @works = Work.find(:all, conditions: [all_conditions, arguments])
                       
    render action: 'index'
  end

  # GET /works/1
  # GET /works/1.json
  def show
    if current_user.nil? || current_user.id != @work.user.id
      @work.increment(:read_count)
    end
    
    
    if @work.draft?
      if !current_user.nil?
        if current_user.id != @work.user.id
          flash[:failure] = "This story is not currently published."
        end
      end
    end
    
    if !@work.save
      flash[:failure] = "Could not increment read_count"
    end
  end

  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  def topdf
    @work.increment(:downloaded)
    @work.save
  end

  # POST /works
  # POST /works.json
  def create
    @work = Work.new(work_params)
    @work.draft = false
    @work.downloaded = 0
    
    if signed_in?
      @work.user = current_user
    end

    respond_to do |format|
      if @work.save
        
        @work..generate_pdf
        
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render action: 'show', status: :created, location: @work }
      else
        format.html { render action: 'new' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def save_as_draft
    @work = Work.find(params[:id])
    respond_to do |format|
      if @work.update_attribute(:draft, true)
        format.html { redirect_to @work, notice: 'Draft was successfully saved.' }
        format.json { render action: 'show', status: :created, location: @work }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /drafts
  # POST /drafts.json
  def create_draft
    @work = Work.new(work_params)
    @work.draft = true
    
    if signed_in?
      @work.user = current_user
    end

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work.user, notice: 'Draft was successfully saved. Awaiting approval.' }
        format.json { render action: 'show', status: :created, location: @work }
      else
        format.html { render action: 'new' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    @work.update_attribute(:draft, false)
    
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work.user, notice: 'Work was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    end

    def set_works
      @works = published_works
    end

    def set_unapproved_works
      @works = Work.where(approved: false)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:work).permit(:blurb, :title, :author_name, :body, :mature, :genre)
    end
end
