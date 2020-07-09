require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe 'タスク一覧機能' do
        before do
            # テストユーザAを作成
            user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
            # 作成者がテストユーザAのタスクを作成
            FactoryBot.create(:task, name: '最初のタスク', user: user_a)
        end

        context 'ユーザAがログインしている時' do
            before do
                # ユーザAでログインする
                # ログインページへ遷移
                visit login_path
                # メールアドレスをテキストフィールドに入力
                fill_in 'メールアドレス', with: 'a@example.com'
                # パスワードをテキストフィールドに入力
                fill_in 'パスワード', with: 'password'
                # ログインボタンを押す
                click_button 'ログインする'
            end

            it 'ユーザAが作成したタスクが表示される' do
                # 作成済みのタスクの名称が画面上に表示していることを確認
                expect(page).to have_content '最初のタスク'
            end
        end
    end
end