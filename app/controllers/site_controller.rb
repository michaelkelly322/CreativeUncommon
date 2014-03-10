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
    @donated = 0.0;
    @total_works = Work.count(:id)
    @total_words = Work.sum(:word_count)
  end
end
