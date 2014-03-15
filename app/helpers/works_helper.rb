module WorksHelper
  def donated_s(in_id)
    Donation.where(work_id: in_id, approved: true).sum(:amount).to_s
  end
end
