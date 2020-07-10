require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe 'タスク一覧機能' do
        # テストユーザを作成
        let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com') }
        let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com') }

        before do
            # 作成者がテストユーザAのタスクを作成
            FactoryBot.create(:task, name: '最初のタスク', user: user_a)
            # ログインする処理の定義
            # ログインページへ遷移
            visit login_path
            # メールアドレスをテキストフィールドに入力
            fill_in 'メールアドレス', with: login_user.email
            # パスワードをテキストフィールドに入力
            fill_in 'パスワード', with: login_user.password
            # ログインボタンを押す
            click_button 'ログインする'
        end

        context 'ユーザAがログインしている時' do
            let(:login_user) { user_a }

            it 'ユーザAが作成したタスクが表示される' do
                # 作成済みのタスクの名称が画面上に表示していることを確認
                expect(page).to have_content '最初のタスク'
            end
        end

        context 'ユーザBがログインしている時' do
            let(:login_user) { user_b }

            it 'ユーザAが作成したタスクが表示されない' do
                # ユーザAが作成したタスクが表示されないことを確認
                expect(page).not_to have_content '最初のタスク'
            end
        end
    end
end