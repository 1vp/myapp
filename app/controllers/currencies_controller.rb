#encoding: UTF-8
class CurrenciesController < ApplicationController

  def index
    if params[:search].present?
      @date_civil = Date.civil(params[:search]["date(1i)"].to_i,
                               params[:search]["date(2i)"].to_i,
                               params[:search]["date(3i)"].to_i).to_s
    else
      @date_civil = Date.current.to_s
    end
    @result = Currency.get_specific_date(@date_civil)
    if @result.blank?
      @result = Currency.load_from_cbr?(@date_civil)
    end
  end

  def show
    @currency = Currency.find(params[:id])
  end
end