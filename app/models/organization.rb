class Organization < ApplicationRecord
  validates_presence_of :name

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
end
