require 'csv'
require 'kconv'

class Sale < ApplicationRecord
  belongs_to :fiscal_year
  belongs_to :member

  def self.import(csv)
    csv_text = csv.read
    csv_utf = CSV.parse( Kconv.toutf8(csv_text) )

    header = csv_utf.first
    fiscal_year_names = header[2..4]  #=> ['2017/03/31, '2018/03/31', '2019/03/31']
    fiscal_years = fiscal_year_names.map do | fy_name |
                     end_at = fy_name.to_time
                     start_at = end_at - 12.months
                     FiscalYear.where(name: fy_name, start_at: start_at, end_at: end_at).first_or_create
                   end

    csv_utf.each do | row |
      break if row[0] == '売上高合計'
      division = Division.where(name: row[0]).first_or_create
      member = Member.where(full_name: row[1], division: division).first_or_create
      i = 1
      fiscal_years.each do | fiscal_year |
        sale = member.sales.where(fiscal_year: fiscal_year).first_or_create
        sale.update(amount: row[i+1])
        i = i + 1
      end
    end
  end
end
