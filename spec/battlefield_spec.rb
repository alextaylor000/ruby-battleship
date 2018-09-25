require 'spec_helper'

def ship(origin:, length: 3)
  { origin: origin, length: length }
end

RSpec.describe Battlefield do
  subject(:battlefield) do
    ship1 = ship(origin: [0, 0])
    ship2 = ship(origin: [1, 2])
    ship3 = ship(origin: [0, 4])

    Battlefield.new(ship1, ship2, ship3)
  end

  it 'can be instantiated with ship locations' do
    expect(battlefield.ships.length).to eq 3
  end

  it 'can render itself' do
    expected_render = "hey"
    result = battlefield.render

    result.each do |row|
      puts row.join(' ')
    end
    expect(battlefield.render).to eq expected_render
  end

  describe 'overlapping ships' do
    [
      [[ship(origin: [0, 0]), ship(origin: [0, 0])], :raise],
      [[ship(origin: [0, 0]), ship(origin: [1, 0])], :raise],
      [[ship(origin: [0, 0]), ship(origin: [3, 0])], :ok],
      [[ship(origin: [2, 0]), ship(origin: [5, 0])], :ok],
      [[ship(origin: [0, 0]), ship(origin: [0, 1])], :ok],
    ].each do |ships, result|
      it 'prevents overlapping ships' do
        if result == :raise
          expect { Battlefield.new(*ships) }.to raise_error Battlefield::OverlappingShipsError
        else
          expect { Battlefield.new(*ships) }.to_not raise_error
        end
      end
    end
  end

  describe '#render_row' do
    it 'renders a row given ships on that row' do
      ship = ship(origin: [2, 0])
      ship2 = ship(origin: [6, 0])

      battlefield = Battlefield.new(ship, ship2)

      expect(battlefield.render_row([ship])).to eq %w(- - X X X - - - - -)
      expect(battlefield.render_row([ship, ship2])).to eq %w(- - X X X - X X X -)
    end
  end
end

# SAMPLE BOARD:
# 10
# 9
# 8
# 7
# 6
# 5
# 4 - - -
# 3
# 2   - - -
# 1
# 0 - - -
#   0 1 2 3 4 5 6 7 8 9 10

