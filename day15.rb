require 'set'

class Node
  attr_accessor :key
  attr_accessor :g, :h, :w
  attr_accessor :edges, :prev_key
  attr_accessor :pcount

  def initialize(key, h, w)
    @key = key
    @g = 0
    @h = h
    @w = w
    @prev_key = ''
    @edges = []
    @pcount = 0
  end

  def f
    g + h
  end
end


def transform_data(data)
  cells = data.each {|line| line.chars }
  max_x = cells[0].length - 1
  max_y = cells.length - 1

  h_scale = 1

  nodes = Hash.new
  cells.each_with_index do |row, x|
    row.chars.each_with_index do |value, y|
      key = [x,y].join('-')
      distance = max_x - x + max_y - y
      node = Node.new(key, distance * h_scale, value.to_i)
      node.edges << [x + 1, y].join('-')
      node.edges << [x - 1, y].join('-')
      node.edges << [x, y + 1].join('-')
      node.edges << [x, y - 1].join('-')

      nodes[key] = node
    end
  end

  [nodes, max_x, max_y]
end


def step(nodes, open, closed, node)
  node.edges.each do |adj_key|
    next if closed.include? adj_key

    adj = nodes[adj_key]
    next if adj.nil?

    if adj.g == 0
      adj.g = node.g + adj.w
      adj.prev_key = node.key
    else
      new_f = node.g + adj.w + adj.h
      if new_f < adj.f
        adj.g = node.g + adj.w
        adj.prev_key = node.key
      end
    end

    unless open.include? adj
      open << adj
    end
  end
end


def dump_path(nodes, node)
  path = [node]
  while true
    next_node = nodes[node.prev_key]
    break if next_node.nil?

    path << next_node
    node = next_node
  end

  path.reverse
end


def part_one(data)

  raise "Broke part one trying to speed up part two, look at sets"
  nodes, max_x, max_y = data
  open = []
  closed = []
  current = nodes['0-0']
  last_key = "#{max_x}-#{max_y}"

  steps = 0
  while true
  # 100.times do
    step(nodes, open, closed, current)

    # puts "- #{current.key}   (#{open.size})"
    closed << current.key
    open.delete current


    open.sort! { |a, b| a.f <=> b.f }
    current = open[0]

    break if current.nil?



    break if current.key == last_key
    # puts "#{sorted.size}  #{current.key}  #{current.g}   #{current.f}"

    steps += 1
  end

  puts "Took #{steps} steps "

  path = dump_path nodes, nodes[last_key]
  path.each { |step| puts "#{step.key} (#{step.w})   " }
  total = path.reduce(0) { |sum, step| sum + step.w }
  puts total - nodes['0-0'].w


  # nodes.each_pair { |k, v| puts "#{k}  --  #{v.pcount}" }
end


def biggify(nodes, orig_max_x, orig_max_y)
  max_x = orig_max_x * 5
  max_y = orig_max_y * 5

  nodes.each do |key, node|
    x, y = key.split(/\-/).map(&:to_i)
    node.h = (max_x - x + max_y - y)
  end

  col_nodes = nodes.clone

  # Go down the map first
  (1...5).each do |i|
    nodes.each do |key, node|
      x, y = key.split(/\-/).map(&:to_i)

      new_x = x
      new_y = (orig_max_y * i) + y
      new_key = [new_x, new_y].join('-')

      w = node.w + i
      w = (w - 9) if w > 9

      h = max_x - new_x + max_y - new_y
      n = Node.new new_key, h, w
      col_nodes[new_key] = n
    end
  end

  new_nodes = col_nodes.clone

  # Go across the rows
  (1...5).each do |i|
    col_nodes.each do |key, node|
      x, y = key.split(/\-/).map(&:to_i)

      new_x = (orig_max_x * i) + x
      new_y = y
      new_key = [new_x, new_y].join('-')

      w = node.w + i
      w = (w - 9) if w > 9

      h = max_x - new_x + max_y - new_y
      n = Node.new new_key, h, w
      new_nodes[new_key] = n
    end
  end

  # Fix the edge keys
  new_nodes.each do |key, node|
    x, y = key.split(/\-/).map(&:to_i)

    node.edges = [
      [x + 1, y].join('-'),
      [x - 1, y].join('-'),
      [x, y + 1].join('-'),
      [x, y - 1].join('-')
    ]
  end
  new_nodes


  # (0...50).each do |i|
  #   (0...50).each do |j|
  #     n = new_nodes[[i, j].join('-')]
  #     # print n.w
  #     print " #{n.key} "
  #   end
  #   puts
  # end

end


def part_two(data)
  start_nodes, max_x, max_y = data
  nodes = biggify(start_nodes, max_x + 1, max_y + 1)

  max_x = ((max_x + 1) * 5) - 1
  max_y = ((max_y + 1) * 5) - 1

  open = []
  closed = Set.new

  current = nodes['0-0']
  last_key = [max_x, max_y].join('-')
  steps = 0

  while true
    step(nodes, open, closed, current)

    closed << current.key
    open.delete current

    sorted = open.sort { |a, b| a.f <=> b.f }
    current = sorted[0]

    break if current.nil?
    break if current.key == last_key
    puts "#{sorted.size}  #{closed.size}  #{current.key}  #{current.g}   #{current.f}"

    steps += 1
  end

  puts "Took #{steps} steps "

  path = dump_path nodes, nodes[last_key]
  # path.each { |step| puts "#{step.key} (#{step.w})   " }
  total = path.reduce(0) { |sum, step| sum + step.w }
  puts total - nodes['0-0'].w



end


