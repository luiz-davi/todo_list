class ListsController < ApplicationController
  before_action :set_list, only: %i[ show edit update destroy finished enable ]

  # GET /lists or /lists.json
  def index
    @lists = current_user.lists.order(created_at: :asc)
  end

  def finishedies
    @finishedies = current_user.lists.where(finished: true)
  end

  def open
    @open = current_user.lists.where(finished: false).order(created_at: :asc)
  end

  # GET /lists/1 or /lists/1.json
  def show
    @tasks = @list.tasks.order(created_at: :asc)
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists or /lists.json
  def create
    @list = List.new(list_params.merge({user_id: current_user.id}))

    respond_to do |format|
      if @list.save
        format.html { redirect_to list_url(@list), notice: "Lista criada com sucesso." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to list_url(@list), notice: "Lista atualizada com sucesso" }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "Lista foi excluída com sucesso." }
      format.json { head :no_content }
    end
  end

  def finished
    @list.update(finished: true)

    redirect_to list_finishedies_path, notice: "Lista foi concluída com sucesso." 
    
  end

  def enable
    @list.update(finished: false)

    redirect_to list_open_path, notice: "Lista foi restaurada com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      id = params[:id] || params[:list_id]
      @list = current_user.lists.find(id)
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:name, :finished)
    end
end
