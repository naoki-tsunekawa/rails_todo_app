class TasksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    # viewから渡されたパラメータでオブジェクトを生成
    task = Task.new(task_param)
    # DB保存
    task.save!
    # Flashメッセージを
    redirect_to tasks_url, notice: "タスク 「#{task.name}」を登録しました。"
  end

  def edit
  end

  private

  def task_param
    params.require(:task).permit(:name, :description)
  end
end
