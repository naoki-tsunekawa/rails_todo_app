class TasksController < ApplicationController
  # ====タスク一覧====
  def index
    # DBからデータを全件取得
    @tasks = Task.all
  end

  # ====タスク詳細====
  def show
    # findメソッドを使用してタスク詳細を表示する為に必要なオブジェクトを取得する
    @task = Task.find(params[:id])
  end

  # ====タスク新規登録====
  def new
    @task = Task.new
  end

  def create
    # viewから渡されたパラメータでオブジェクトを生成
    @task = Task.new(task_param)
    # DB保存(create)
    if @task.save
      # Flashメッセージを設定
      redirect_to tasks_url, notice: "タスク 「#{@task.name}」を登録しました。"
    else
      # 失敗した場合に再度登録画面を呼び出す
      render :new
    end
    
    
  end

  # ====タスク編集====
  def edit
    # DBから該当するデータを検索し、オブジェクトを生成
    @task = Task.find(params[:id])
  end

  def update
    # DBから該当するデータを検索し、オブジェクトを生成
    task = Task.find(params[:id])
    # DB保存(create)
    task.update!(task_param)
    # Flashメッセージを設定
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  # ====タスク削除====
  def destroy
    # DBから該当するデータを検索し、オブジェクトを生成
    task = Task.find(params[:id])
    # データ削除
    task.destroy
    # Flashメッセージを設定
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  private

  def task_param
    params.require(:task).permit(:name, :description)
  end
end
