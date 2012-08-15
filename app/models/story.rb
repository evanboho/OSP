class Story < ActiveRecord::Base
  attr_accessible :age, :approved_at, :body, :gender, :name, :title, :email

  validates_presence_of :title, :body
  validates_numericality_of :age, :allow_blank => true

  scope :unapproved, where("approved_at IS ?", nil)
  scope :approved, where("approved_at <= ?", Time.now)

  before_save :titleize_title

  def approve
    self.update_attribute(:approved_at, Time.now)
  end

  def disapprove
    self.update_attribute(:approved_at, nil)
  end

  def approved?
    approved_at != nil
  end

  def titleize_title
    self.title = self.title.titleize
  end

end
