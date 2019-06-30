class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    
    has_many(
        :artwork_shares,
        dependent: :destroy,
        class_name: 'ArtworkShare',
        foreign_key: :viewer,
        primary_key: :id
    )

    has_many(
        :shared_artworks,
        through: :artwork_shares,
        source: :artwork
    )

    has_many(
        :artworks,
        dependent: :destroy,
        class_name: 'Artwork',
        foreign_key: :artist_id,
        primary_key: :id
    )

end