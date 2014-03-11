module SiteHelper
  def page_title_tag(imgName, opt={})
    out = ''
    out << '<div style="margin-top: 5px;"><div class="content-panel centered" style="width: 194px; margin-bottom: 15px;">'
    out << image_tag(imgName) << '</div></div>'
    
    out.html_safe
  end
end
