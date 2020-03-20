class Pet < ActiveRecord::Base
  validates_presence_of :name, :species, :breed, :age
  belongs_to :user
end
