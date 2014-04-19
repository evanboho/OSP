class Comment < ActiveRecord::Base
  belongs_to :story

  validates :name, :length => { :maximum => 12 }
  validates :title, :length => { :maximum => 20 }

  scope :approved, -> {where("approved_by IS NOT ?", nil)}
  scope :unapproved, -> {where(:approved_by => nil)}

  def approved?
    approved_at
  end

  def approve=(is_approved)
    self.approved_at = is_approved == 'true' ? Time.now : nil
  end

end
