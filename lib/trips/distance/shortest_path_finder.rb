module Trips
  module Distance
    class ShortestPathFinder
      Struct.new('Node', :name, :dist)

      def initialize(args)
        @graph = args.fetch(:graph)
        @starting_node = args.fetch(:starting_node)
        @ending_node = args.fetch(:ending_node)
      end

      def find_optimum_path
        calculate_min_paths
        min_path
      end

      private

      attr_reader :graph, :starting_node, :ending_node

      def dijkstra
        nodes = []
        nodes += graph.nodes

        queue = {}
        nodes.each { |vertice| queue[vertice] = Struct::Node.new(nil, Float::INFINITY) }

        queue[starting_node].name = starting_node
        queue[starting_node].dist = 0

        current_node = Struct::Node.new(starting_node, 0)

        while true do
          next_node = Struct::Node.new(nil, Float::INFINITY)
          if !graph.edges[current_node.name].nil?
            graph.edges[current_node.name].each do |node, dist|
              next if node == starting_node
              if current_node.dist + dist < queue[node].dist
                queue[node].name = current_node.name
                queue[node].dist = current_node.dist + dist
                if current_node.dist + dist < next_node.dist
                  next_node.name = node
                  next_node.dist = dist
                end
              end
            end
          end
          nodes.delete(current_node.name)

          break if nodes.empty?

          current_node.name = next_node.name
          current_node.dist = next_node.dist unless next_node.dist == Float::INFINITY

          if current_node.name.nil?
            current_node.name = nodes.first
          end
        end
        queue
      end

      def min_path
        @min_path ||= begin
          min_path = { nodes: [], distance: 0, cost: 0 }

          current = ending_node
          return if calculate_min_paths[current].dist == Float::INFINITY

          while true do
            min_path[:nodes] << current
            if current == starting_node
              min_path[:nodes] = min_path[:nodes].reverse.join(' ')
              break
            end

            current = calculate_min_paths[current].name
          end
          min_path[:distance] = calculate_min_paths[ending_node].dist
          min_path[:cost] = (@fuel_liter_price.to_f * min_path[:distance].to_f) / @autonomy.to_f
          min_path
        end
      end

      def calculate_min_paths
        @calculate_min_paths ||= dijkstra
      end
    end
  end
end
