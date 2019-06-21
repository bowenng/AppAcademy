class TagTopic < ApplicationRecord
    validates :tag, presence: true, uniqueness: true

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :tag_id,
        primary_key: :id
    )

    has_many :urls,
        through: :taggings,
        source: :url

    def popular_links
        urls.joins(:visits).group(:long_url, :short_url).select("long_url, short_url, COUNT(visits.id) AS num_visits").order("COUNT(visits.id)").limit(5)
    end
end