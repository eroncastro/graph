# Graph

I have chosen the trains challenge, because it is a problem related to graphs which I like.

## Start

    bundle

## Running tests

    bundle exec rspec

## Running the application

On the root directory of the application, type:

    ruby trains.rb -i <input_file.txt>

The input file MUST be an existent one. Otherwise, it will throw an exception.

## Motivations

First of all, I designed this code using Ruby because it is the language I am most
familiar with.

- The route_distance_calculator.rb uses a simple interation to calculate the distances between
nodes by using Ruby convenient each_cons.
- The less_than_maximum_finder, exact_stops_finder and maximum_stops_finder walk through the graph
using a convenient recursive algorithm.
- The shortest_path_finder use the AMAZING Djikstra's algorithm to solve the problem of the shortest path.


## TO DO's

- If I was to refactor this code, I would start using inheritance of exact_stops_finder.rb,
maximum_stops_finder.rb and less_than_maximum_finder.rb
- Refactor Dijkstra algorithm using a priority queue