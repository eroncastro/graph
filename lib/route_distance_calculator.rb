class RouteDistanceCalculator
  def initialize(graph)
    @graph = graph
  end

  def distance(route)
    return error_message if route.size < 2

    distance = 0
    route.each_cons(2) do |pair|
      return error_message if pair_distance(pair.first, pair.last).nil?

      distance += pair_distance(pair.first, pair.last)
    end
    distance
  end

  private

  attr_reader :graph, :route

  def pair_distance(origin, destiny)
    graph.edges[origin][destiny]
  end

  def error_message
    'NO SUCH ROUTE'
  end
end