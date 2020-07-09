class Task < ApplicationRecord
    # 検証前の値を正規化
    before_validation :set_nameless_name

    # バリデーション設定
    validates :name, presence: true, length: { maximum:30 }
    validate :check_name

    belongs_to :user
    
    private
    def check_name
        if name&.include?(',')
            errors.add(:name, 'にカンマを含めることはできません')
        end
    end

    def set_nameless_name
        if name.blank?
            self.name = '名前なし'
        end
    end
end
