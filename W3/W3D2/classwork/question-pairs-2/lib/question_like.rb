require_relative 'questions_db_x.rb'

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    like = QuestionsDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    return nil unless like.length > 0

    QuestionLike.new(like.first)
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
