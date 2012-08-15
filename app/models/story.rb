class Story < ActiveRecord::Base
  attr_accessible :age, :approved_at, :body, :gender, :name, :title, :email

  validates_presence_of :title, :body
  validates_numericality_of :age, :allow_blank => true
end
