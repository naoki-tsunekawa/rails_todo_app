require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe 'タスク一覧機能' do
        # テストユーザを作成
        let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com') }
        let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com') }
        let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

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

        # 共通のテストケース定義
        shared_examples_for 'ユーザAが作成したタスクが表示される' do
            it { expect(page).to have_content '最初のタスク' }
        end

        context 'ユーザAがログインしている時' do
            # ユーザAでログイン
            let(:login_user) { user_a }
            # '最初のタスク'が表示されているかテスト
            it_behaves_like 'ユーザAが作成したタスクが表示される'
        end

        context 'ユーザBがログインしている時' do
            let(:login_user) { user_b }

            it 'ユーザAが作成したタスクが表示されない' do
                # ユーザAが作成したタスクが表示されないことを確認
                expect(page).not_to have_content '最初のタスク'
            end
        end

        describe 'タスク詳細表示機能' do
            context 'ユーザAがログインしている時' do
                let(:login_user) { user_a }
                before do
                    visit task_path(task_a)
                end
                # '最初のタスク'が表示されているかテスト
                it_behaves_like 'ユーザAが作成したタスクが表示される'
            end
        end
    end
end