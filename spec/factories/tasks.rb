FactoryBot.define do
    # テスト用のタスクデータ作成
    factory :task do
        name { 'テストタスク' }
        description { 'RSpec & Capybara & FactoryBotを準備する。' }
        association :user, factory: :user
    end
end