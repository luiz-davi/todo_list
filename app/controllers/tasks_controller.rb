class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: %i[ show edit update destroy enable desable]

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @list.tasks.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @list.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to list_path(@list), notice: "Tarefa foi criada com sucesso." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to list_task_path(@list), notice: "Tarefa foi atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to list_path(@list), notice: "Tarefa foi excluída com sucesso." }
      format.json { head :no_content }
    end
  end

  def enable
    @task.update(done: false)

    redirect_to list_path(@list), notice: "Tarefa foi reativada com sucesso."
  end

  def desable
    @task.update(done: true)

    redirect_to list_path(@list), notice: "Tarefa foi finalizada com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      id = params[:id] || params[:task_id]
      @task = @list.tasks.find(id)
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:list_id, :done, :desscription)
    end
end
