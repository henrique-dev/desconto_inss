class User < ApplicationRecord
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :cpf, presence: true
  validates :birth_date, presence: true
  validates :wage, presence: true

  before_create :set_deduction
  before_update :set_deduction

  def set_deduction
    self.deduction = User.calculate_deduction(wage)
  end

  def self.ranges
    [
      { v: 1045, p: 7.5, q: 0 },
      { v: 2089.60, p: 9.0, q: 0 },
      { v: 3134.40, p: 12.0, q: 0 },
      { v: 6101.06, p: 14.0, q: 0 },
      { v: 10_448, p: 14.5, q: 0 },
      { v: 20_896, p: 16.5, q: 0 },
      { v: 40_747.20, p: 19.0, q: 0 },
      { p: 22, q: 0 }
    ]
  end

  def self.calculate_ranges
    users = User.all
    ranges = self.ranges
    users.each do |user|
      ranges.size.times do |i|
        if !ranges[i][:v].nil?
          if user.wage <= ranges[i][:v]
            ranges[i][:q] += 1
            break
            end
        else
          ranges[i][:q] += 1
          end
      end
    end
    ranges
  end

  def self.calculate_deduction(wage)
    deduction = BigDecimal(0)
    wage = BigDecimal(wage, 2)

    ranges.size.times do |i|
      first_range = BigDecimal((i > 0 ? ranges[i - 1][:v] : 0), 8)
      current_range = (!ranges[i][:v].nil? ? BigDecimal(ranges[i][:v], 8) : nil)
      percent_deduction = BigDecimal(ranges[i][:p], 8)
      if current_range.nil?
        deduction += (wage - first_range) * (percent_deduction / BigDecimal(100))
      else
        if wage > current_range
          deduction += ((current_range - first_range) * (percent_deduction / BigDecimal(100)))
        else
          deduction += (wage - first_range) * (percent_deduction / BigDecimal(100))
          break
        end
      end
    end
    deduction.truncate(2).to_s
  end
end
