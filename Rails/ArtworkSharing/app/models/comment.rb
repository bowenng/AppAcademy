class Comment < ApplicationRecord
    validates :commenter_id, presence: true
    validates :artwork_id, presence: true
    validates :body, presence: true

    belongs_to(
        :artwork,
        class_name: 'Artwork',
        foreign_key: :artwork_id,
        primary_key: :id
    )

    belongs_to(
        :commenter,
        class_name: 'User',
        foreign_key: :commenter_id,
        primary_key: :id
    )
end