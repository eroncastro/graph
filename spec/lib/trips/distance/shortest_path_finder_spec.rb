require_relative '../../../../lib/trips/distance/shortest_path_finder.rb'
require_relative '../../../../models/graph.rb'

RSpec.describe Trips::Distance::ShortestPathFinder do
  let(:input) { 'spec/fixtures/input.txt' }
  let(:graph) { Graph.new(input) }
  let(:instance) { described_class.new(args) }
  let(:args) do
    {
      graph: graph,
      starting_node: starting_node,
      ending_node: ending_node
    }
  end

  describe '#shortest_path_distance' do
    subject(:shortest_path_distance) { instance.shortest_path_distance }

    context 'when trip starts at A and ends at C' do
      let(:starting_node) { 'A' }
      let(:ending_node) { 'C' }

      it { is_expected.to eq 9 }
    end

    context 'when trip starts at B and ends at B' do
      let(:starting_node) { 'B' }
      let(:ending_node) { 'B' }

      it { is_expected.to eq 9 }
    end
  end
end
