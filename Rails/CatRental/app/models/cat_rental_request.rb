class CatRentalRequest < ApplicationRecord
    validates :cat_id, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true, inclusion: {in: ["PENDING", "APPROVED", "DENIED"]}

    validate :does_not_overlap_approved_request
    validate :is_valid_rental_interval

    belongs_to(
        :cat,
        class_name: 'Cat',
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