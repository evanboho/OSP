class Story < ActiveRecord::Base
  attr_accessor :approve
  validates_presence_of :title, :message => "story needs a title"
  validates_presence_of :body, :message => "story is empty"
  validates_numericality_of :age, :allow_blank => true
  validates_inclusion_of :age, :in => 1..120, :allow_blank => true, :message => "is invalid"
  validates_length_of :name, :maximum => 20, :message => "is too long"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :allow_blank => true, format: { with: VALID_EMAIL_REGEX }

  has_many :comments, :dependent => :destroy

  scope :unapproved, -> { where("approved_at IS ?", nil) }
  scope :approved, -> { where.not(approved_at: nil) }
  scope :featured, -> { where(:featured => true) }
  scope :with_unapproved_comments, -> { joins(:comments).where(comments: { approved_at: nil }).uniq }

  before_save :titleize_title

  def feature!
    Story.featured.each do |story|
      story.update_attribute(:featured, false)
    end
    self.update_attribute(:featured, true)
  end

  def approved_by=(admin)
    self.approved_at = admin.present? ? Time.now : nil
    super(admin.is_a?(Admin) ? admin.id : admin)
  end

  def approver
    return unless approved_by
    if is_integer? approved_by
      Admin.find approved_by
    else
      approved_by
    end rescue nil
  end
  alias_method :admin, :approver

  def approver_email
    approver.try(:email) || approver
  end

  def approved?
    approved_at.present?
  end

  def titleize_title
    self.title = self.title.titleize
  end

  private

  def is_integer? str
    str.to_i.to_s.length == str.length
  end

end
