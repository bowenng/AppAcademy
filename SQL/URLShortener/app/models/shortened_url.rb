class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true, uniqueness: true
    validates :user_id, presence: true

    def self.create!(long_url, user)
        user_id = user.id
        short_url = random_code
        self.create(short_url: random_code, long_url: long_url, user_id: user_id)
    end

    def num_clicks
        visits.length
    end

    def num_uniques
        visitors.length
    end

    def num_recent_uniques
        visits.select('visitor_id').where('created_at > ?', 10.minutes.ago).distinct.count
    end

    private
    def self.random_code
        code = SecureRandom.urlsafe_base64
        while self.exists?(:long_url => code)
            code = SecureRandom.urlsafe_base64
        end
        code
    end

    

    belongs_to(
        :submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :url_id,
        primary_key: :id
    )

    has_many :visitors,
        Proc.new { distinct },
        through: :visits,
        source: :visitor
    

end