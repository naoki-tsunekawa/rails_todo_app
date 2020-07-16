class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  # ====タスク一覧====
  def index
    # ログインしているユーザーに紐づくTaskだけ表示する
    # @tasks = current_user.tasks.recent
    # 
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).recent
  end

  # ====タスク詳細====
  def show
  end

  # ====タスク新規登録====
  def new
    @task = Task.new
  end

  def create
    # viewから渡されたパラメータでオブジェクトを生成
    # user_idを含めた状態でTaskデータを登録する
    @task = current_user.tasks.new(task_params)

    # 確認画面で'戻る'ボタンを押された場合
    if params[:back].present?
      # 新規登録画面へ遷移
      render :new
      # 処理を終了
      return
    end

    # DB保存(create)
    if @task.save
      # Flashメッセージを設定
      redirect_to @task, notice: "タスク 「#{@task.name}」を登録しました。"
    else
      # 失敗した場合に再度登録画面を呼び出す
      render :new
    end
  end

  # ====タスク登録確認画面====
  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  # ====タスク編集====
  def edit
  end

  def update
    # DBから該当するデータを検索し、オブジェクトを生成
    @task = current_user.tasks.find(params[:id])
    # DB保存(create)
    @task.update!(task_params)
    # Flashメッセージを設定
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  # ====タスク削除====
  def destroy
    # データ削除
    @task.destroy
    # Flashメッセージを設定
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private

  def set_task
      # findメソッドを使用してタスク詳細を表示する為に必要なオブジェクトを取得する
      @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
