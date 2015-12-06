module Trips
  module Distance
    class LessThanMaximumFinder
      def initialize(args)
        @graph = args.fetch(:graph)
        @starting_node = args.fetch(:starting_node)
        @ending_node = args.fetch(:ending_node)
        @maximum_distance = args.fetch(:maximum_distance)
        @paths = []
      end

      def count_trips
        find_paths(starting_node, Array.new, 0)

        paths.size
      end

      private

      attr_reader :graph, :paths, :starting_node, :ending_node, :maximum_distance

      def find_paths(current_node, current_path, current_distance)
        return if reached_maximum_distance?(current_distance)

        current_path << current_node

        if reached_ending_node?(current_node) && has_not_reached_maximum_distance?(current_distance)
          paths << current_path.join.to_s
        end

        graph[current_node].keys.each do |node|
          find_paths(node, current_path.clone, current_distance + graph[current_node][node])
        end
      end

      def reached_maximum_distance?(current_distance)
        current_distance > maximum_distance
      end

      def reached_ending_node?(current_node)
        current_node == ending_node
      end

      def has_not_reached_maximum_distance?(current_distance)
        current_distance > 0 && current_distance < maximum_distance
      end
    end
  end
end
