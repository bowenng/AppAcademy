class Cat < ApplicationRecord
    validates :name, presence: true
    validates :birth_date, presence: true
    validates :sex, presence: true, inclusion: { in: ["M", "F"]}
    validates :color, presence: true, inclusion: {in: ["black", "white", "blue", "green", "yellow", "red", "pink"]}
    validates :description, presence: true
    validate :does_not_overlap_approved_request
    validate :is_valid_rental_interval
    
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


    def overlapping_requests
        CatRentalRequest.where(cat_id: self.cat_id).where("? BETWEEN start_date and end_date", self.start_date)
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: "APPROVED")
    end

    def does_not_overlap_approved_request
        if overlapping_approved_requests.exists?
            errors[:overlapping] << "request"
        end
    end

    def is_valid_rental_interval
        if end_date < start_date
            errors[:interval] << "invalid: end date cannot be earlier than start date"
        end
    end
end