class Response < ApplicationRecord
    validates :user_id, presence: true
    validates :question_id, presence: true
    validates :answer_choice_id, presence: true

    validate :not_duplicate_response
    validate :respondent_is_not_poll_author

    def not_duplicate_response
        previous_response = Response.find_by(user_id: self.user_id, question_id: self.question_id)
        unless previous_response.nil?
            errors[:duplicate] << "response"
        end
    end

    def respondent_is_not_poll_author
        poll_author_id = Poll.joins(questions: :answer_choices).where("answer_choices.id = ? AND questions.id = ?", self.answer_choice_id, self.question_id).pluck('polls.user_id').first


        respondent_id = self.user_id
        if poll_author_id == respondent_id
            errors[:author] << 'cannot respond to his/her own question'
        end
    end

    belongs_to(
        :question,
        class_name: 'Question',
        foreign_key: :question_id,
        primary_key: :id
    )
    
    belongs_to(
        :answer_choice,
        class_name: 'AnswerChoice',
        foreign_key: :answer_choice_id,
        primary_key: :id
    )

    belongs_to(
        :respondent,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    def sibling_responses
        self.question.responses.where.not(id: self.id)
    end

    
end