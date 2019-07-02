class CatRentalRequest < ApplicationRecord
    validates :cat_id, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true, inclusion: {in: ["PENDING", "APPROVED", "DENIED"]}

    belongs_to(
        :cat,
        class_name: 'Cat',
        foreign_key: :cat_id,
        primary_key: :id
    )
end