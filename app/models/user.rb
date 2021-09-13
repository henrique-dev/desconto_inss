class User < ApplicationRecord
    has_one :address, dependent: :destroy

    def self.ranges
        [
            {:v => 1045, :p => 7.5, :q => 0},
            {:v => 2089.60, :p => 9.0, :q => 0},
            {:v => 3134.40, :p => 12.0, :q => 0},
            {:v => 6101.06, :p => 14.0, :q => 0},
            {:v => 10448, :p => 14.5, :q => 0},
            {:v => 20896, :p => 16.5, :q => 0},
            {:v => 40747.20, :p => 19.0, :q => 0},
            {:p => 22, :q => 0},
        ]
    end

    def self.calculate_deduction wage
        deduction = BigDecimal(0)
        wage = BigDecimal(wage, 2)
    
        self.ranges.size.times do |i|            
            first_range = BigDecimal( (i > 0 ? self.ranges[i-1][:v] : 0), 8 )
            current_range = (self.ranges[i][:v] != nil ? BigDecimal( self.ranges[i][:v], 8 ) : nil)
            percent_deduction = BigDecimal( self.ranges[i][:p], 8 )
            if (current_range == nil)
                deduction += (wage - first_range) * (percent_deduction / BigDecimal(100))
            else
                if (wage > current_range)
                    deduction += ((current_range - first_range) * (percent_deduction / BigDecimal(100)))
                else
                    deduction += (wage - first_range) * (percent_deduction / BigDecimal(100))
                    break
                end
            end
        end
        return deduction.truncate(2).to_s
    end
end
