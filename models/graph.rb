class Graph
  def initialize(input_file)
    @input_file = input_file
  end

  def nodes
    @nodes ||= edges.keys
  end

  def edges
    @edges ||= generate_edges
  end

  private

  attr_reader :input_file

  def generate_edges
    edges = {}

    File.open(input_file, 'r').each_line do |line|
      starting_node, ending_node, distance = line.split('', 3)

      [starting_node, ending_node].each do |vertex|
        edges[vertex] = {} unless edges.key?(vertex)
      end

      edges[starting_node][ending_node] = distance.to_i
    end
    edges
  end
end
