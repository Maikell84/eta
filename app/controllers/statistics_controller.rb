class StatisticsController < ApplicationController
  before_action :set_statistic, only: %i[ show edit update destroy ]

  def index
    @grouped_consumptions = Consumption.where('created_at >= ?', 31.days.ago.beginning_of_day).where('created_at > ?', Date.parse('2021-03-19')).group_by{|x| x.created_at.strftime("%Y-%m-%d")}

    consumption_weekly
    consumption_monthly
    consumption_monthly_cw
  end

  def consumption_weekly
    @consumptions_weekly = []
    7.downto(0).each do |day|
      consumption_day = day.days.ago.beginning_of_day
      values_of_the_day = @grouped_consumptions.dig(consumption_day.strftime("%Y-%m-%d")).pluck(:value)
      consumption_for_day = values_of_the_day.max - values_of_the_day.min
      @consumptions_weekly << OpenStruct.new(weekday: I18n.l(consumption_day, format: '%A'), day: consumption_day.strftime("%d.%m.%Y"), value: "#{consumption_for_day}kg")
    end
  end

  def consumption_monthly
    @consumptions_monthly = []
    31.downto(0).each do |day|
      consumption_day = day.days.ago.beginning_of_day
      values_of_the_day = @grouped_consumptions.dig(consumption_day.strftime("%Y-%m-%d"))&.pluck(:value)
      next unless values_of_the_day

      consumption_for_day = values_of_the_day.max - values_of_the_day.min
      @consumptions_monthly << OpenStruct.new(weekday: I18n.l(consumption_day, format: '%A'), day: consumption_day.strftime("%d.%m.%Y"), value: "#{consumption_for_day}kg")
    end
  end

  def consumption_monthly_cw
    @consumptions_monthly_cw = []
    53.downto(0).each do |week|
      consumption_week_start = week.weeks.ago.beginning_of_week
      consumption_week_end = week.weeks.ago.end_of_week
      values_of_the_week_min = @grouped_consumptions.dig(consumption_week_start.strftime("%Y-%m-%d"))&.pluck(:value)
      values_of_the_week_max = @grouped_consumptions.dig(consumption_week_end.strftime("%Y-%m-%d"))&.pluck(:value)
      next unless values_of_the_week_min && values_of_the_week_max

      consumption_for_cw = values_of_the_week_max.max - values_of_the_week_min.min
      @consumptions_monthly_cw << OpenStruct.new(weekday: "KW #{I18n.l(consumption_week_start, format: '%U')}", day: "KW #{consumption_week_start.strftime("%U")}", value: "#{consumption_for_cw}kg")
    end

  end

end
