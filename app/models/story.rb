class Story < ActiveRecord::Base
  attr_accessible :age, :approved_at, :body, :gender, :name, :title, :email

  validates_presence_of :title, :message => "story needs a title"
  validates_presence_of :body, :message => "story is empty"
  validates_numericality_of :age, :allow_blank => true
  validates_inclusion_of :age, :in => 1..120, :allow_blank => true, :message => "invalid age"
  validates_length_of :name, :maximum => 20, :message => "name is too long"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :allow_blank => true, format: { with: VALID_EMAIL_REGEX }

  belongs_to :admin

  scope :unapproved, where("approved_at IS ?", nil)
  scope :approved, where("approved_at IS NOT ?", nil)

  before_save :titleize_title

  def approve(approver_id)
    self.update_attribute(:approved_at, Time.now)
    self.update_attribute(:admin_id, approver_id)
  end

  def disapprove
    self.update_attribute(:approved_at, nil)
    self.update_attribute(:admin_id, nil)
  end

  def approver
    self.admin
  end

  def approved?
    approved_at != nil
  end

  def titleize_title
    self.title = self.title.titleize
  end

end
