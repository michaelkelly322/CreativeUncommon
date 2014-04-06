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
  
  # => instance methods
  def generate_pdf
    pdf_path = Rails.root.join('tmp', 'pdf_temps',"temp_#{self.id}.pdf")
    Prawn::Document.generate(pdf_path) do |pdf|
      pdf.text_box self.title, at: [50, 500], size: 24
      pdf.text_box self.author_name, at: [50, 470], size: 16
      
      pdf.start_new_page
      
      pdf.text self.body.html_safe
    end
    
    File.open(pdf_path, 'rb') do |file|
      self.update_attribute(:pdf, file.read)
    end
    
    File.delete(pdf_path)
  end
  
  # => Private Methods
  private
    def count_words(str)
      str.split.size
    end
end
