module SiteHelper
  def page_title_tag(imgName, opt={})
    out = ''
    out << '<div style="margin-top: 5px;"><div class="content-panel centered" style="width: 194px; margin-bottom: 15px;">'
    out << image_tag(imgName) << '</div></div>'
    
    out.html_safe
  end
  
  def fill_stories(path)
    card_path = Rails.root.join('app', 'assets', path)
    content = Hash.new
    
    Dir.glob(card_path.join('*.txt')) do |file|
      logger.debug "#{file}"
      
      file_name = file.split('/').last
      
      story_name_raw = file_name.split('.').first
      story_name = story_name_raw.split.map(&:capitalize).join(' ')
      
      File.open(file) do |text|
        content[story_name] = text.read
      end
    end
    
    return content
  end
  
  def fill_images(path)
    image_path = Rails.root.join('app', 'assets', 'images', path)
    content = Hash.new
    
    Dir.glob(image_path.join('*')) do |file|
      pipeline_path = file.split('images/').last
      file_name = file.split('/').last
      
      image_name_raw = file_name.split('.').first
      image_name = image_name_raw.split.map(&:capitalize).join(' ')
      
      content[image_name] = pipeline_path
    end
    
    return content
  end
  
  def fill_cover_photos(path)
    photo_path = Rails.root.join('app', 'assets', 'images', path)
    content = Hash.new
    
    Dir.glob(photo_path.join('*_cover.JPG')) do |file|
      pipeline_path = file.split('images/').last
      file_name = file.split('/').last
      
      photo_name_raw = file_name.split('.').first
      photo_name_raw.slice!('_cover')
      photo_name_raw.slice!('e_')
      photo_name = photo_name_raw.split.map(&:capitalize).join(' ')
      
      
      content[photo_name] = pipeline_path
    end
    
    return content
  end
  
  def fill_photos(path)
    photo_path = Rails.root.join('app', 'assets', 'images', path)
    content = Hash.new
    
    logger.debug 'photo_path = ' + photo_path
    
    Dir.glob(photo_path.join('*.JPG')) do |file|
      pipeline_path = file.split('images/').last
      file_name = file.split('/').last
      
      logger.debug 'pipeline_path(JPG) = ' + pipeline_path
      
      photo_name_raw = file_name.split('.').first
      photo_name_raw.slice!('_cover')
      photo_name_raw.slice!('e_')
      photo_name = photo_name_raw.split.map(&:capitalize).join(' ')
      
      
      content[photo_name] = pipeline_path
    end
    
    Dir.glob(photo_path.join('*.jpg')) do |file|
      pipeline_path = file.split('images/').last
      file_name = file.split('/').last
      
      logger.debug 'pipeline_path(jpg) = ' + pipeline_path
      
      photo_name_raw = file_name.split('.').first
      photo_name_raw.slice!('_cover')
      photo_name_raw.slice!('e_')
      photo_name = photo_name_raw.split.map(&:capitalize).join(' ')
      
      
      content[photo_name] = pipeline_path
    end
    
    return content
  end
end
