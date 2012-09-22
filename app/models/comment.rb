class Comment < ActiveRecord::Base
  attr_accessible :content, :email, :name, :title, :story_id, :approved_by
  belongs_to :story
  
  validates :name, :length => { :maximum => 12 } 
  validates :title, :length => { :maximum => 20 }
  
  scope :approved, where("approved_by IS NOT ?", nil)
  scope :unapproved, where(:approved_by => nil)
  
  def approved?
    approved_by.present?
  end
  
end
