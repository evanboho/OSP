class Story < ActiveRecord::Base
  attr_accessible :age, :approved_at, :body, :gender, :name, :title, :email

  validates_presence_of :title, :message => "story needs a title"
  validates_presence_of :body, :message => "story is empty"
  validates_numericality_of :age, :allow_blank => true
  validates_inclusion_of :age, :in => 1..120, :message => "invalid age"
  validates_length_of :name, :maximum => 20, :message => "name is too long"
  validates_format_of :email, :with => /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/,
                      :message => "invalid email"

  scope :unapproved, where("approved_at IS ?", nil)
  scope :approved, where("approved_at IS NOT ?", nil)

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
