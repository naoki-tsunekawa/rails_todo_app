require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe 'タスク一覧機能' do
        # テストユーザを作成
        let(:user_a) { FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com') }
        let(:user_b) { FactoryBot.create(:user, name: 'ユーザB', email: 'b@example.com') }
        let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

        # テスト実行前準備
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

        # タスク一覧機能のテスト
        context 'ユーザAがログインしている時' do
            # ユーザAでログイン
            let(:login_user) { user_a }

            # '最初のタスク'が表示されているかテスト
            it_behaves_like 'ユーザAが作成したタスクが表示される'
        end

        context 'ユーザBがログインしている時' do
            # ユーザBでログイン
            let(:login_user) { user_b }

            it 'ユーザAが作成したタスクが表示されない' do
                # ユーザAが作成したタスクが表示されないことを確認
                expect(page).not_to have_content '最初のタスク'
            end
        end

        # タスク詳細機能のテスト
        describe 'タスク詳細表示機能' do
            context 'ユーザAがログインしている時' do
                # ユーザAでログイン
                let(:login_user) { user_a }
                
                # テスト実行前準備
                before do
                    # タスクを新規作成する
                    visit task_path(task_a)
                end

                # '最初のタスク'が表示されているかテスト
                it_behaves_like 'ユーザAが作成したタスクが表示される'
            end
        end

        # タスク新規作成機能のテスト
        describe 'タスク新規作成機能' do
            # ユーザAでログイン
            let(:login_user) { user_a }

            # テスト実行前準備
            before do
                # タスクを新規作成する
                visit new_task_path
                fill_in '名前', with: task_name
                click_button '登録する'
            end

            # 新規登録成功テストケース
            context '新規作成画面で名前を入力した時' do
                # 
                let(:task_name) { '新規作成のテストを書く' }
            
                it '正常に作成される' do
                    expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
                end
            end

            # 新規登録失敗テストケース
            context 'タスク新規作成機能で名称を入力しなかった時' do
                # 
                let(:task_name) { '' }

                it 'エラーとなる' do
                    within '#error_explanation' do
                        expect(page).to have_content '名前を入力してください'
                    end
                end
            end
            
        end

    end
end