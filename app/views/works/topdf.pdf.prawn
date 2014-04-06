prawn_document(force_download: true) do |pdf|
	pdf.text_box @work.title, at: [50, 500], size: 24
	pdf.text_box @work.author_name, at: [50, 470], size: 16
	
	pdf.start_new_page
	
	pdf.text @work.body.html_safe
end
