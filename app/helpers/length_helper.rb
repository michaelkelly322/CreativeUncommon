module LengthHelper
  def length_select_tag(name)
    out = ''
    out << tag('select', name: name, id: 'select-' + name) 
    out << '<option value="" selected="selected">Select...</option>'
    
    LENGTH_CONFIG.keys.each do |k|
      out << '<option value="' << k << '">' << LENGTH_CONFIG[k]['display'] << '</option>'
    end
    
    out << '</select>'
    out.html_safe
  end
  
  def get_length_min(id)
    if !LENGTH_CONFIG[id].nil?
      LENGTH_CONFIG[id]['min']
    end
  end
  
  def get_length_max(id)
    if !LENGTH_CONFIG[id].nil?
      LENGTH_CONFIG[id]['max']
    end
  end
  
  def right_length(id, len)
    if !LENGTH_CONFIG[id].nil?
      len >= LENGTH_CONFIG[id]['min'] && len <= LENGTH_CONFIG[id]['max']
    end
  end
  
  def length_display(id)
    if !LENGTH_CONFIG[id].nil?
      LENGTH_CONFIG[id]['display']
    end
  end
end