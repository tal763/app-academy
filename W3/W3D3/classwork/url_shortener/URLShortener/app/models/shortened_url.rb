class ShortenedUrl < ApplicationRecord
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to(
      :submitter,
      class_name: :User,
      foreign_key: :user_id,
      primary_key: :id
  )

  has_many(
    :visits,
    class_name: :Visit,
    foreign_key: :url_id,
    primary_key: :id
  )


  has_many(
    :visitors,
    Proc.new { distinct }, #<<<
    through: :visits,
    source: :visitor

  )

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visits.select(:user_id).count
  end

  def num_recent_uniques
    self.num_uniques.where(:created_at >= 10.minutes.ago)
  end

  def self.create_new_shortened_url(user, long_url)
    ShortenedUrl.create!(user_id: user.id, short_url: self.random_code, long_url: long_url)
  end

  def self.random_code
    url = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(short_url: url)
      url = SecureRandom.urlsafe_base64(16)
    end
    url
  end

end
