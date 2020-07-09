FactoryBot.define do
    # テスト用のユーザデータを作成
    factory :user do
        name { 'テストユーザー' }
        email { 'test1@example.com' }
        password { 'password' }
    end
end