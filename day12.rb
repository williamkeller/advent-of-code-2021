require 'set'

def transform_data(data)
  data.map { |row| row.split(/\-/) }
end


$path_count = 0

def walk(graph, node, path = '', visited = [])
  path += node + ' '

  if node == 'end'
    puts 'PATH:  ' + path
    $path_count += 1
    return
  end

  if node =~ /[a-z]+/
    return if visited.include? node

    visited << node
  end

  graph[node].each do |dest|
    walk(graph, dest, path, visited.clone)
  end
end


def walk_twice(graph, node, path = '', visited = [], twice = '')
  path += node + ' '


  if node == 'end'
    puts 'PATH:  ' + path
    $path_count += 1
    return
  end

  if node =~ /[a-z]+/ && node != 'start'
    if visited.include? node
      if twice.empty?
        twice = node
      else
        return
      end
    else
      visited << node
    end
  end

  graph[node].each do |dest|
    next if dest == 'start'
    walk_twice(graph, dest, path, visited.clone, twice)
  end
end



def part_one(data)
  graph = Hash.new { Array.new }

  data.each do |src, dst|
    graph[src] = (graph[src] << dst)
    if src != 'start' && dst != 'end'
      graph[dst] = (graph[dst] << src)
    end
  end

  walk(graph, 'start')

  puts $path_count
end



def part_two(data)

  start = Time.now
  graph = Hash.new { Array.new }

  data.each do |src, dst|
    graph[src] = (graph[src] << dst)
    if src != 'start' && dst != 'end'
      graph[dst] = (graph[dst] << src)
    end
  end

  walk_twice(graph, 'start')

  puts $path_count
  puts "Elapsed time: #{ (Time.now - start) * 1000 } ms"
end
