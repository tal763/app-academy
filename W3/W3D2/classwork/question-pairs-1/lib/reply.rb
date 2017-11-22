require_relative 'questions_db_x.rb'

class Reply
  attr_accessor :id, :body, :question_id, :parent_id, :user_id

  def self.find_by_id(id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil unless reply.length > 0

    Reply.new(reply.first)
  end

  def self.find_children_by_parent_id(id)
    replies = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
      parent_id = ?

    SQL
    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    return nil unless replies.length > 0
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    reply = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil unless reply.length > 0
    reply.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    # returns a reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    #returns an array of replies
    Reply.find_children_by_parent_id(@id)
  end

end
