require_relative 'questions_db_x.rb'

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    user = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    return nil unless user.length > 0

    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil unless user.length > 0
    user.map { |name| User.new(name) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    raise 'No questions' if Question.find_by_author_id(@id).nil?
    Question.find_by_author_id(@id)
  end

  def authored_replies
    raise 'No replies' if Reply.find_by_user_id(@id).nil?
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end
end
