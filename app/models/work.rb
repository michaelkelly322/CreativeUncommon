class Work < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, presence: true
  validates :title,
              presence: true,
              length: { maximum: 100 }
              
  validates :blurb,
              presence: true,
              length: { maximum: 250 }
              
  validates :body,
              presence: true,
              length: {maximum: 4294967296 }
  
  # => Callbacks
  before_save { self.word_count = count_words(self.body)}
  
  # => Private Methods
  private
    def count_words(str)
      str.split.size
    end
end
