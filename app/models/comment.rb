class Comment < ActiveRecord::Base
  attr_accessible :content, :email, :name, :title, :story_id
  belongs_to :story
  
  validates :name, :length => { :maximum => 12 } 
  validates :title, :length => { :maximum => 20 }
  
end
