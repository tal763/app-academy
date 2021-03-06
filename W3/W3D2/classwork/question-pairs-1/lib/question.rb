require_relative 'questions_db_x.rb'

class Question
  attr_accessor :title, :body, :user_id, :id

  def self.find_by_id(id)
    question = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    return nil unless question.length > 0

    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    return nil unless questions.length > 0
    questions.map { |question| Question.new(question) }
  end


  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    raise 'No reply' if Question.find_by_question_id(@id).nil?
    Question.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end
end
