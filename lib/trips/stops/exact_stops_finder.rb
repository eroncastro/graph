module Trips
  module Stops
    class ExactStopsFinder
      def initialize(args)
        @graph = args.fetch(:graph)
        @starting_node = args.fetch(:starting_node)
        @ending_node = args.fetch(:ending_node)
        @maximum_stops = args.fetch(:maximum_stops)
        @paths = []
      end

      def count_trips
        find_paths(starting_node, Array.new, 0)

        paths.size
      end

      private

      attr_reader :graph, :paths, :starting_node, :ending_node, :maximum_stops

      def find_paths(current_node, current_path, current_stops)
        return if reached_maximum_stops?(current_stops)

        current_path << current_node

        if reached_ending_node?(current_node) && has_up_to_maximum_stops?(current_stops)
          paths << current_path.join.to_s
        end

        graph.edges[current_node].keys.each do |node|
          find_paths(node, current_path.clone, current_stops + 1)
        end
      end

      def reached_maximum_stops?(current_stops)
        current_stops > maximum_stops
      end

      def reached_ending_node?(current_node)
        current_node == ending_node
      end

      def has_up_to_maximum_stops?(current_stops)
        current_stops > 0 && current_stops == maximum_stops
      end
    end
  end
end
