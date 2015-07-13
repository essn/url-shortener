# == Schema Information
#
# Table name: urls
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  url           :string           not null
#  shortened_url :string           not null
#

class Url < ActiveRecord::Base
  validates :url, presence: true
  before_create :generate_url, :trim_whitespace

  RESTRICTED_WORDS = [
    'foo',
    'bar'
  ]

  def trim_whitespace
    self.url.strip
  end

  def generate_url
    url_id = (0...5).map { (65 + rand(26)).chr }.join

    url_id = (0...5).map { (65 + rand(26)).chr }.join unless is_valid_url?(url_id)

    self.shortened_url = "short.en/#{url_id}"
  end

  def is_valid_url?(url)
    char_diff_less_than_one?(url) || Url.find_by(shortened_url: url) || includes_restricted_words?(url) ? false : true
  end

  def includes_restricted_words?(url)
    restricted = false

    RESTRICTED_WORDS.each do |word|
      restricted = true if url.include? word
    end

    restricted
  end

  def char_diff_less_than_one?(str)
    char_diff = false

    Url.all.each do |url|
      other_str = url.shortened_url.dup
      str.chars{|char| other_str.sub!(char, '')}
      char_diff = other_str.size == 1
      break if char_diff == true
    end

    char_diff
  end
end
