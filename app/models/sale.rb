require 'csv'
require 'kconv'

class Sale < ApplicationRecord
  belongs_to :fiscal_year
  belongs_to :member

  def self.import(csv)
    csv_text = csv.read
    csv_utf = CSV.parse( Kconv.toutf8(csv_text) )
    header = csv_utf.first
    fiscal_year_names = header[2..4]
    fiscal_years = fiscal_year_names.map do | fy_name |
                     end_at = fy_name.to_time.end_of_day
                     start_at = (end_at - 1.year).tomorrow.beginning_of_day
                     FiscalYear.where(name: fy_name, start_at: start_at, end_at: end_at).first_or_create
                   end
    csv_utf.slice!(0)
    csv_utf.each do | row |
      break if row[0] == '売上高合計'
      division = Division.where(name: row[0]).first_or_create
      member = Member.where(full_name: row[1], division: division).first_or_create
      fiscal_years.each.with_index(1) do | fiscal_year, i |
        sale = member.sales.where(fiscal_year: fiscal_year).first_or_create
        amount = row[i+1].gsub(',', '').to_i
        sale.update(amount: amount)
      end
    end
  end
end
