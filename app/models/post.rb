class Post < ApplicationRecord
  belongs_to :end_user
  has_one_attached :image
end
