module GenreHelper
  def genre_select_tag(name, opt={})
    out = ''
    out << tag('select', name: name, class: opt[:class].nil? ? "" : opt[:class], id: 'select-' + name) 
    out << '<option value="" selected="selected">Select...</option>'
    
    GENRE_CONFIG.keys.each do |k|
      out << '<option disabled="disabled">' << k.capitalize << '</option>'
      
      GENRE_CONFIG[k].keys.each do |l|
        out << '<option value="' << l << '">&#160;&#160;' << GENRE_CONFIG[k][l] << '</option>' 
      end
    end
    out << '</select>'
    out.html_safe
  end
end