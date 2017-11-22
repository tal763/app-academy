class Visit < ApplicationRecord
  validates :user_id, :url_id, presence: true;

  def record_visit!(user, shortened_url)
    Visit.create!(user.user_id, shortened_url.id)
  end

belongs_to(
  :visitor,
  class_name: :User,
  foreign_key: :user_id,
  primary_key: :id
)

belongs_to(
  :url
  class_name: :ShortenedUrl,
  foreign_key: :url_id,

)




end
