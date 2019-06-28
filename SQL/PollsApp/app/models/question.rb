class Question < ApplicationRecord
    validates :text, presence: true

    has_many(
        :answer_choices,
        class_name: 'AnswerChoice',
        foreign_key: :question_id,
        primary_key: :id
    )

    belongs_to(
        :poll,
        class_name: 'Poll',
        foreign_key: :poll_id,
        primary_key: :id
    )

    has_many(
        :responses,
        class_name: 'Response',
        foreign_key: :question_id,
        primary_key: :id
    )

    def results
        distribution = Hash.new()

        counts = Question.joins(responses: :answer_choice).where(id: self.id).group("answer_choices.id").select("answer_choices.text AS choice, COUNT(*) AS votes")

        counts.each do |count|
            distribution[count.choice] = count.votes
        end

        distribution
    end
end