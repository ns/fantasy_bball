require 'rubygems'
require 'nokogiri'
require 'open-uri'

COLUMNS = %w(No Player G Min Pts Reb Ast Stl Blk To Pf Dreb Oreb Fgm-a Pct 3gm-a Pct Ftm-a Pct eff)
ALL_PLAYER_STATS = "http://www.hoopsstats.com/basketball/fantasy/nba/playerstats/15/1/eff/1-1"
SG_STATS         = "http://www.hoopsstats.com/basketball/fantasy/nba/playerstats/15/3/eff/1-1"

page = Nokogiri::HTML(open(ALL_PLAYER_STATS))

stats = []
page.css('table table.statscontent tr').each do |tr|
  player_stats = tr.css('td').collect(&:text)
  stats << player_stats.each_with_index.map{|stat, i| { COLUMNS[i] => stat }}.inject(&:merge)
end

puts stats.inspect