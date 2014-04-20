class Story < ActiveRecord::Base
  attr_accessor :approve
  validates_presence_of :title, :message => "story needs a title"
  validates_presence_of :body, :message => "story is empty"
  validates_numericality_of :age, :allow_blank => true
  validates_inclusion_of :age, :in => 1..120, :allow_blank => true, :message => "invalid age"
  validates_length_of :name, :maximum => 20, :message => "name is too long"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :allow_blank => true, format: { with: VALID_EMAIL_REGEX }

  belongs_to :admin
  has_many :comments, :dependent => :destroy

  scope :unapproved, -> { where("approved_at IS ?", nil) }
  scope :approved, -> { where.not(approved_at: nil) }
  scope :featured, -> { where(:featured => true) }

  before_save :titleize_title

  def approve=(is_approved)
    self.approved_at = is_approved == 'true' ? Time.now : nil
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
