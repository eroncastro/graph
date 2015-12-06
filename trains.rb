require 'optparse'
require 'ostruct'
require_relative 'models/graph.rb'
require_relative 'lib/route_distance_calculator.rb'
require_relative 'lib/trips/stops/maximum_stops_finder.rb'
require_relative 'lib/trips/stops/exact_stops_finder.rb'
require_relative 'lib/trips/distance/shortest_path_finder.rb'
require_relative 'lib/trips/distance/less_than_maximum_finder.rb'

class TrainsEntryPoint
  def self.parse(args)
    options = OpenStruct.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: trains.rb [options]'

      opts.on('-i', '--input TEXT FILE',
              'Requires the .txt input file before executing the script') do |input|
        options.input = input
      end
    end

    begin
      opt_parser.parse!(args)
      unless File.exist?(options.input)
        puts "Error: The supplied file '#{options.input}' does not exist."
        exit
      end
      options
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument
      puts $!.to_s
      puts optparse
      exit
    end
  end
end

options = TrainsEntryPoint.parse(ARGV)
graph = Graph.new(options.input)

counter = 0
# Calculating distance of given routes

distance_routes = [%w(A B C), %w(A D), %w(A D C), %w(A E B C D), %w(A E D)]
distance_calculator = RouteDistanceCalculator.new(graph)

distance_routes.each_with_object(distance_calculator) do |routes, obj|
  counter += 1
  puts "OUTPUT ##{counter}: #{obj.distance(routes)}"
end

# Calculating routes based on the maximum number of stops

counter += 1

maximum_number_of_stops_args = {
  graph: graph,
  starting_node: 'C',
  ending_node: 'C',
  maximum_stops: 3
}

maximum_stops_route_counter =
  Trips::Stops::MaximumStopsFinder.new(maximum_number_of_stops_args)
puts "OUTPUT ##{counter}: #{maximum_stops_route_counter.count_trips}"

# Calculating routes based on the EXACT number of stops

counter += 1

exact_number_of_stops_args = {
  graph: graph,
  starting_node: 'A',
  ending_node: 'C',
  maximum_stops: 4
}

exact_stops_route_counter =
  Trips::Stops::ExactStopsFinder.new(exact_number_of_stops_args)
puts "OUTPUT ##{counter}: #{exact_stops_route_counter.count_trips}"

# Calculating the length of the shortest route from A to C

counter += 1

shortest_path_from_A_to_C_args = {
  graph: graph,
  starting_node: 'A',
  ending_node: 'C'
}

shortest_path_finder_A_to_C =
  Trips::Distance::ShortestPathFinder.new(shortest_path_from_A_to_C_args)
puts "OUTPUT ##{counter}: #{shortest_path_finder_A_to_C.shortest_path_distance}"

# Calculating the length of the shortest route from B to B

counter += 1

shortest_path_from_B_to_B_args = {
  graph: graph,
  starting_node: 'B',
  ending_node: 'B'
}

shortest_path_finder_B_to_B =
  Trips::Distance::ShortestPathFinder.new(shortest_path_from_B_to_B_args)
puts "OUTPUT ##{counter}: #{shortest_path_finder_B_to_B.shortest_path_distance}"

# Calculating the number of different routes with a distance less than 30

counter += 1

less_than_distance_args = {
  graph: graph,
  starting_node: 'C',
  ending_node: 'C',
  maximum_distance: 30
}

require 'pry'
binding.pry

less_than_distance_route_counter =
  Trips::Distance::LessThanMaximumFinder.new(less_than_distance_args)
puts "OUTPUT ##{counter}: #{less_than_distance_route_counter.count_trips}"
