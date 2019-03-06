class SalesController < ApplicationController
  def index
    @sales = Sale.all
    @fiscal_years = FiscalYear.order(:end_at).limit(3)
    @members = Member.all
  end

  def import
    Sale.import(params[:csv])
    redirect_to action: :index
  end
end
