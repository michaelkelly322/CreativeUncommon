module WorksHelper
  def donated_s(in_id)
    don = Donation.where(work_id: in_id, approved: true)

    unless don.empty?
      don.sum(:amount)
    else
      ''
    end
  end
  
  def published_works
    Work.where(approved: true, draft: false)
  end
end
