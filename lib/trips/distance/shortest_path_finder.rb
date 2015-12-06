module Trips
  module Distance
    class ShortestPathFinder
      Struct.new('Node', :origin, :distance)

      def initialize(args)
        @graph = args.fetch(:graph)
        @starting_node = args.fetch(:starting_node)
        @ending_node = args.fetch(:ending_node)
      end

      def shortest_path_distance
        @shortest_path_distance ||= shortest_paths[ending_node].distance
      end

      private

      attr_reader :graph, :starting_node, :ending_node

      def shortest_paths
        @shortest_paths ||= dijkstra
      end

      def dijkstra
        nodes = []

        if starting_node == ending_node
          @ending_node = "#{@ending_node}2"

          graph.nodes << ending_node
          graph.edges.each do |key, value|
            value[ending_node] = value[starting_node] if value.key?(starting_node)
          end
          graph.edges[ending_node] = graph.edges[starting_node]
        end

        nodes += graph.nodes
        queue = {}
        nodes.each { |vertice| queue[vertice] = Struct::Node.new(nil, Float::INFINITY) }

        queue[starting_node].origin = starting_node
        queue[starting_node].distance = 0

        current_node = starting_node

        while true do
          graph.edges[current_node].each do |node, distance|
            if distance + queue[current_node].distance < queue[node].distance
              queue[node].origin = current_node
              queue[node].distance = distance + queue[current_node].distance
            end
          end
          nodes.delete(current_node)

          break if nodes.empty?

          temp = queue.reject { |key, value| !nodes.include?(key) }
          temp = temp.select { |key, value| value.origin == current_node }
          current_node = temp.min_by { |key, value| value.distance }
          current_node = current_node.nil? ? nodes.first : current_node.first
        end
        queue
      end
    end
  end
end
