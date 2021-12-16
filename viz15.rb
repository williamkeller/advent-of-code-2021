require 'gosu'
require_relative 'day15.rb'

class Viz15Window < Gosu::Window
  attr_reader :data

  HEIGHT = 768
  WIDTH = 1024
  SETSIZE = 250
  PADDING = 0

  def initialize(data)
    start_nodes, max_x, max_y = transform_data(data)

    @nodes = biggify(start_nodes, max_x + 1, max_y + 1)

    @max_x = ((max_x + 1) * 5) - 1
    @max_y = ((max_y + 1) * 5) - 1

    @open = []
    @closed = Set.new

    @current = @nodes['0-0']
    @last_key = [@max_x, @max_y].join('-')
    @steps = 0

    @running = true

    super WIDTH, HEIGHT
    self.caption = "Day 15 Visualizer"

    @tilewidth = 2
    @basecolor = Gosu::Color::RED
  end


  def step_sim
    step(@nodes, @open, @closed, @current)

    @closed << @current.key
    @open.delete @current

    sorted = @open.sort { |a, b| a.f <=> b.f }
    @current = sorted[0]

    if @current.nil? || @current.key == @last_key
      @running = false
      return
    end

    @steps += 1


#     puts "Took #{steps} steps "

#     path = dump_path nodes, nodes[last_key]
#     total = path.reduce(0) { |sum, step| sum + step.w }
#     puts total - nodes['0-0'].w
  end



  def update
    if @running
      step_sim
    end
  end


  def draw
    # SETSIZE.times do |x|
    #   SETSIZE.times do |y|
    #     draw_rect(x * @tilewidth, y * @tilewidth, @tilewidth, @tilewidth, @basecolor)
    #   end
    # end

    # path = dump_path @nodes, @nodes[@last_key]

    # path.each do |p|
    #   x, y = p.key.split(/\-/).map(&:to_i)
    #   puts "#{x}, #{y}"
    #   draw_rect(x * @tilewidth, y * @tilewidth, @tilewidth, @tilewidth, Gosu::Color::WHITE)
    # end

    x, y = @current.key.split(/\-/).map(&:to_i)
    draw_rect(x * @tilewidth, y * @tilewidth, @tilewidth, @tilewidth, Gosu::Color::GREEN)

    path = dump_path(@nodes, @current)

    path.each do |p|
      x, y = p.key.split(/\-/).map(&:to_i)
      puts "#{x}, #{y}"
      draw_rect(x * @tilewidth, y * @tilewidth, @tilewidth, @tilewidth, Gosu::Color::WHITE)
    end
  end

end



def main
  data = File.readlines("data/day15.txt").map(&:strip)
  Viz15Window.new(data).show
end


main

