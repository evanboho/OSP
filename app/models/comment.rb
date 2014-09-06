class Comment < ActiveRecord::Base
  belongs_to :story

  validates :name, :length => { :maximum => 12 }
  validates :title, :length => { :maximum => 20 }
  validates_presence_of :content

  scope :approved, -> {where("approved_at IS NOT ?", nil)}
  scope :unapproved, -> {where(:approved_at => nil)}

  def approved?
    approved_at.present?
  end

  def approved_by=(admin)
    return unless admin
    self.approved_at = Time.now
    super(admin.is_a?(Admin) ? admin.id : admin)
  end

  def approved_by=(admin)
    self.approved_at = admin.present? ? Time.now : nil
    super(admin.is_a?(Admin) ? admin.id : admin)
  end

end
