require 'byebug'

class Battlefield
  attr_reader :ships

  def initialize(*ships)
    @ships = ships

    ensure_no_overlapping_ships!
  end

  def render
    [].tap do |board|
      10.times do |i|
        ships_for_row = ships.select { |s| s[:origin][1] == i}
        board << render_row(ships_for_row)
      end
    end.reverse
  end

  def render_row(ships)
    new_row = Array.new(10, '-')

    ships.each do |s|
      length = s[:length]
      x_start = s[:origin][0]
      x_end = x_start + length

      new_row[x_start...x_end] = Array.new(length, 'X')
    end

    new_row
  end

  private

  def ensure_no_overlapping_ships!
    ships_by_rows = ships.group_by { |s| s[:origin][1] }

    ships_by_rows.each do |_, ships|
      sorted_ships = ships.sort_by { |s| s[:origin][0] }
      first_ship = sorted_ships.first
      last_ship  = sorted_ships.last

      area = (last_ship[:origin][0] + last_ship[:length]) - first_ship[:origin][0]

      overlap = area < ships.sum { |s| s[:length ]}

      raise OverlappingShipsError if overlap
    end
  end

  class OverlappingShipsError < StandardError; end
end
