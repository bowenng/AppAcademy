class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true
    validates :artist_id, presence: true

    validates :title, uniqueness: {
        scope: :artist_id,
        message: "An artist cannot have two paintings with the same name."
    }

    belongs_to(
        :artist,
        class_name: 'User',
        foreign_key: :artist_id,
        primary_key: :id
    )

    has_many(
        :artwork_shares,
        dependent: :destroy,
        class_name: 'ArtworkShare',
        foreign_key: :artwork_id,
        primary_key: :id 
    )

    has_many(
        :shared_viewers,
        through: :artwork_shares,
        source: :viewer
    )

    has_many(
        :comments,
        dependent: :destroy,
        class_name: 'Comment',
        foreign_key: :artwork_id,
        primary_key: :id
    )
end