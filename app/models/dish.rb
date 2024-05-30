class Dish < ApplicationRecord
  belongs_to :group
  has_many :serve_sizes, dependent: :destroy

  accepts_nested_attributes_for :serve_sizes, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, length: { maximum: 200 }
  validates :description, presence: true, length: { maximum: 600 }

  def has_many_serve_size?
    self.serve_sizes.count > 1
  end

  def has_one_serve_size?
    self.serve_sizes.count == 1
  end
end
