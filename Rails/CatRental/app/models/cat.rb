class Cat < ApplicationRecord
    validates :name, presence: true
    validates :birth_date, presence: true
    validates :sex, presence: true, inclusion: { in: ["M", "F"]}
    validates :color, presence: true, inclusion: {in: ["black", "white", "blue", "green", "yellow", "red", "pink"]}
    validates :description, presence: true
    

    def age
        now = Time.now.utc.to_date
        now.year - birth_date.year
    end

    has_many(
        :cat_rental_requests,
        dependent: :destroy,
        class_name: 'CatRentalRequest',
        foreign_key: :cat_id,
        primary_key: :id
    )

    def self.most_recent_request
        Cat.
    end

    
end