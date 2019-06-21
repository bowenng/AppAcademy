class Visit < ApplicationRecord
    validates :visitor_id, null: false
    validates :url_id, null: false

    belongs_to(
        :url,
        class_name: 'ShortenedUrl',
        foreign_key: :url_id,
        primary_key: :id
    )

    belongs_to(
        :visitor,
        class_name: 'User',
        foreign_key: :visitor_id,
        primary_key: :id
    )

    def self.record_visit!(user, short_url)
        visitor_id = user.id
        shortened_url_id = ShortenedUrl.where(:short_url => short_url).first.id
        self.create(visitor_id: visitor_id, url_id: shortened_url_id)
    end

    def self.last_visit
        Visit.all.last.url.short_url
    end
end