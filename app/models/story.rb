class Story < ActiveRecord::Base
  attr_accessible :age, :approved_at, :body, :gender, :name, :title
end
