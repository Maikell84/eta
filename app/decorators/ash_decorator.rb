class AshDecorator < ApplicationDecorator
  def ash_value_percent
    (object.value.to_f / 1000) * 100
  end

  def dial_segment_colors
    ['#00FF00','#CCFF00','#FFCC00','#FF6600', '#FF0000']
  end
end
