class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true, uniqueness: true
    validates :user_id, presence: true
    validate :nonpremium_max, :no_spamming

    def self.create!(long_url, user)
        user_id = user.id
        short_url = random_code
        self.create(short_url: random_code, long_url: long_url, user_id: user_id)
        short_url
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

    def self.prune(n)
        urls_to_prune = ShortenedUrl.joins(:submitter)
                        .joins("LEFT JOIN visits ON visits.url_id = shortened_urls.id")
                        .where("(shortened_urls.id IN
                            (
                                SELECT 
                                    shortened_urls.id
                                FROM 
                                    shortened_urls
                                JOIN
                                    visits ON shortened_urls.id = visits.url_id
                                GROUP BY 
                                    shortened_urls.id
                                HAVING
                                    MAX(visits.created_at) < \'#{n.minutes.ago}\'
                            ))
                            OR 
                            (
                                (visits.id) IS NULL AND (shortened_urls.created_at < \'#{n.minutes.ago}\')
                            )
                            AND
                            (users.premium = FALSE)
                            ").destroy_all
    end
    #validations
    def nonpremium_max
        return if User.find(self.user_id).premium
        num_submitted = User.find(self.user_id).submitted_urls.count
        if num_submitted >= 5
            errors[:only] << "premium members can create more than 5 short urls"
        end
    end

    def no_spamming
        num_recent_submits = ShortenedUrl.where('created_at >= ?', 1.minute.ago).where(user_id: self.user_id).length
        errors[:maximum] << "of 5 short urls per minute" if num_recent_submits >= 5
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
        dependent: :destroy,
        class_name: 'Visit',
        foreign_key: :url_id,
        primary_key: :id
    )

    has_many :visitors,
        Proc.new { distinct },
        through: :visits,
        source: :visitor
    
    has_many(
        :taggings,
        dependent: :destroy,
        class_name: 'Tagging',
        foreign_key: :url_id,
        primary_key: :id
    )

    has_many(
        :tag_topics,
        through: :taggings,
        source: :tag
    )

    

end