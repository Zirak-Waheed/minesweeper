class Board < ApplicationRecord
  validates_presence_of :name, :email
  validates :length, :width, :mines, numericality: { greater_than: 0}
  validate :mines_count
  before_create :populate_state

  private

  def populate_state
    size = length*width
    arr = Array.new(size, 0)
    mines_index = (0...size).to_a.shuffle.take(mines)
    mines_index.each do |i|
      arr[i] = -1
    end
    self.state = arr.each_slice(width)
  end

  def mines_count
    if mines && length && width && mines > length*width
      errors.add(:mines, "can't be greater than total number of cells")
    end
  end
end
