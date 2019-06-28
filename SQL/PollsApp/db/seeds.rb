# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
    #create users
    u1 = User.create(username: 'superbryango')
    u2 = User.create(username: 'tamajessica')
    u3 = User.create(username: 'justinthebeast')
    u4 = User.create(username: 'theowhogivesup')

    #create polls
    p1 = Poll.create(user_id: u1.id, title: 'Computer Science Related')
    p2 = Poll.create(user_id: u2.id, title: 'Becoming Alpha')
    
    #create questions
    q1 = Question.create(poll_id: p1.id, text: 'How to learn JavaScript?')
    q2 = Question.create(poll_id: p2.id, text: 'How to beat my boyfriend?')

    #create answer choices
    a1 = AnswerChoice.create(question_id: q1.id, text: 'Watch Online Courses')
    a2 = AnswerChoice.create(question_id: q1.id, text: 'Reading JavaScript Books')
    a3 = AnswerChoice.create(question_id: q1.id, text: 'Hire a tutor')
    a4 = AnswerChoice.create(question_id: q1.id, text: 'Attend a bootcamp')

    a5 = AnswerChoice.create(question_id: q2.id, text: 'Use your bare hands')
    a6 = AnswerChoice.create(question_id: q2.id, text: 'Hire John Wick')
    a7 = AnswerChoice.create(question_id: q2.id, text: 'Call Jessica')
    a8 = AnswerChoice.create(question_id: q2.id, text: 'Go to gym with Nikita')

    #create responses
    r1 = Response.create(user_id: u1.id, question_id: q1.id, answer_choice_id: a1.id)
    r2 = Response.create(user_id: u2.id, question_id: q1.id, answer_choice_id: a1.id)
    r3 = Response.create(user_id: u3.id, question_id: q1.id, answer_choice_id: a2.id)
    r4 = Response.create(user_id: u4.id, question_id: q1.id, answer_choice_id: a3.id)

    r5 = Response.create(user_id: u1.id, question_id: q2.id, answer_choice_id: a5.id)
    r6 = Response.create(user_id: u2.id, question_id: q2.id, answer_choice_id: a7.id)
    r7 = Response.create(user_id: u3.id, question_id: q2.id, answer_choice_id: a8.id)
    r8 = Response.create(user_id: u4.id, question_id: q2.id, answer_choice_id: a6.id)
end
