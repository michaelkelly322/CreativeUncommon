class SiteController < ApplicationController
  def home
    
  end
  
  def guide
    
  end
  
  def about
    
  end
  
  def faq
    
  end
  
  def stats
    @donated = Donation.all.sum(:amount).to_s;
    @total_works = Work.count(:id)
    @total_words = Work.sum(:word_count)
  end
end
