prawn_document(force_download: true) do |pdf|
	pdf.text @work.title
	pdf.text @work.author_name
	pdf.text @work.body
end
