graph = {}

f = File.open('input.txt', 'r')
f.each_line do |line|
  starting_node, ending_node, distance = line.split('')
  starting_node = starting_node.to_sym
  ending_node = ending_node.to_sym

  [starting_node, ending_node].each do |vertex|
    graph[vertex] = {} if !graph.has_key?(vertex)
  end

  graph[starting_node][ending_node] = distance.to_i
end
f.close

class PathFinder
  attr_accessor :paths

  def initialize(graph, starting_node, ending_node, maximum_stops)
    @graph = graph
    @starting_node = starting_node
    @ending_node = ending_node
    @maximum_stops = maximum_stops
    @paths = []
  end

  def find_path(current_node, current_path, current_stops)
    return if current_stops > maximum_stops

    puts current_node
    current_path << current_node

    if current_node == ending_node && current_stops > 0 && current_stops == maximum_stops
      puts '------------'
      puts current_path.to_s
      puts '------------'
      @paths << current_path.join.to_s
    end

    graph[current_node].keys.each do |node|
      puts current_path.to_s
      find_path(node, current_path.clone, current_stops + 1)
    end
  end

  private

  attr_reader :graph, :starting_node, :ending_node, :maximum_stops
end

x = PathFinder.new(graph, :C, :C, 3)
x.find_path(:C, [], 0)

