class Pdf::General
    def self.begin users
        pdf = Prawn::Document.new(:page_size => "A4", :margin => [20, 20, 20, 20], :page_layout => :portrait)
        self.header(pdf)
        self.page(pdf, users)
		pdf
    end

    def self.header pdf
        linha = [[{:content => "Relatório geral", :colspan => 4}]]
        pdf.table(linha, :width => pdf.bounds.width, :cell_style => { size: 7, padding: 3},) do |row|
			row.row(0).columns(0).font_style = :bold
			row.row(0).columns(0).align      = :center
			row.row(0).columns(0).size       = 12
		end
        pdf.move_down 8
    end

    def self.page pdf, users

        ranges = User.ranges

        users.each do |user|
            ranges.size.times do |i|
                if (ranges[i][:v] != nil)
                    if (user.wage <= ranges[i][:v])
                        ranges[i][:q] += 1
                        break
                    end
                else
                    ranges[i][:q] += 1
                end
            end
        end
    
        linhas = []
        ranges.size.times do |i|
            if (ranges[i][:v] != nil)
                linhas << [{:content => "Com salário até #{("%.2f" % ranges[i][:v]).to_s.gsub(".", ",")}", :colspan => 4, :align => :center, :size => 12}, {:content => ranges[i][:q].to_s, :colspan => 2, :align => :center, :size => 12}]
            else
                linhas << [{:content => "Com salário maior que #{("%.2f" % (ranges[i-1][:v] + 0.01)).to_s.gsub(".", ",")}", :colspan => 4, :align => :center, :size => 12}, {:content => ranges[i][:q].to_s, :colspan => 2, :align => :center, :size => 12}]
            end
        end

        pdf.table(linhas, :width => pdf.bounds.width, :cell_style => { size: 7, padding: 3},) do |row|
            ranges.size.times do |i|
                #row.row(i).columns(0).font_style = :bold
                #row.row(i).columns(0).align = :center
                #row.row(i).columns(0).size = 12
                
                #row.row(i).columns(1).font_style = :bold
                #row.row(i).columns(1).align = :center
                #row.row(i).columns(1).size = 12
            end
		end
        
    end
end