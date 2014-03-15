class Donation < ActiveRecord::Base
  belongs_to :work
  
  validates :amount, presence: true
end
