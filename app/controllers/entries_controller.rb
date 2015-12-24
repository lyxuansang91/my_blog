class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, except: [:show, :index]

  # GET /entries
  # GET /entries.json
  def index
    @entries = signed_in? ? Entry.from_users_followed_by(current_user) : Entry.all
    # byebug
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])
    @comments = @entry.comments.paginate(:page =>  params[:page], :per_page =>  3).order('created_at DESC')
    @comment = Comment.new
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      redirect_to @entry, notice: 'Entry was successfully created.'
    else
      render :new
    end
    # Format code
    #
    # respond_to do |format|
    #   if @entry.save
    #     format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
    #     format.json { render :show, status: :created, location: @entry }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @entry.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :body)
    end


end
