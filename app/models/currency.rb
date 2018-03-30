=begin
t.string :id_currency
t.integer :numCode
t.string :charCode
t.integer :nominal
t.string :name
t.string :value
t.string :previous
=end

require 'nokogiri'
require 'open-uri'
class Currency < ApplicationRecord
  validates :id_currency, :numCode, :nominal, :name, :value, presence: true
  validates :value, numericality: true
  validates :numCode,:nominal, numericality: { only_integer: true }

  scope :get_specific_date, ->(date) {
    where("created_at >= ?", Time.parse(date).beginning_of_day).where("created_at <= ?", Time.parse(date).end_of_day)
  }

  def self.load_from_cbr?(date)
    url = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{Date.parse(date).strftime("%d.%m.%Y")}"
    doc = Nokogiri::XML(open(url))
    @result_last = []
    doc.xpath("//ValCurs//Valute").each do |valute|
      @value = self.get_specific_date(date).where(:numCode => valute.xpath('NumCode').text).first
      if @value.blank?
        @new_object = self.new
        @new_object.id_currency = valute.attribute("ID").text
        @new_object.numCode = valute.xpath('NumCode').text
        @new_object.charCode = valute.xpath('CharCode').text
        @new_object.nominal = valute.xpath('Nominal').text
        @new_object.name = valute.xpath('Name').text
        @new_object.value = valute.xpath('Value').text.to_s.gsub(',', '.').to_f
        @new_object.save
        puts @new_object.errors.full_messages
        @result_last << @new_object
      else
        @result_last << @value
      end
    end
    @result_last
  end

end