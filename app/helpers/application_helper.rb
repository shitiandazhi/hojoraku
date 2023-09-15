module ApplicationHelper

def score_color_class(score)
  case score
  when -Float::INFINITY...-0.8
    "red-score"
  when -0.7...0.1
    "orange-score"
  when 0.0...0.7
    "green-score"
  when 0.8..Float::INFINITY
    "blue-score"
  else
    "default-score" # スコアが範囲外の場合のデフォルトスタイル
  end
end
end