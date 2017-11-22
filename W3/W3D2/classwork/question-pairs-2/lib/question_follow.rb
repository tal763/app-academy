require_relative 'questions_db_x.rb'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.followers_for_question_id(question_id)
    #IDEA user_id, question_id
    users = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_follows ON users.id = question_follows.user_id
      WHERE
        question_id = ?;
    SQL

    return nil if users.empty?

    users.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      WHERE
        question_follows.user_id = ?;
    SQL

    return nil if questions.empty?

    questions.map { |question| Question.new(question) }
  end

  def self.find_by_id(id)
    follow = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    return nil unless follow.length > 0

    QuestionFollow.new(follow.first)
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
