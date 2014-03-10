module SiteHelper
  def page_title_tag(imgName, opt={})
    out = ''
    out << '<div><div class="content-panel centered" style="width: 194px;">'
    out << image_tag(imgName) << '</div></div>'
    
    out.html_safe
  end
end
