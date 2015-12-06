require_relative '../../../../lib/trips/distance/less_than_maximum_finder.rb'
require_relative '../../../../models/graph.rb'

RSpec.describe Trips::Distance::LessThanMaximumFinder do
  let(:input) { 'spec/fixtures/input.txt' }
  let(:graph) { Graph.new(input).edges }
  let(:instance) { described_class.new(args) }
  let(:args) do
    {
      graph: graph,
      starting_node: starting_node,
      ending_node: ending_node,
      maximum_distance: maximum_distance
    }
  end

  describe '#count_trips' do
    subject(:count_trips) { instance.count_trips }

    context 'when trip starts at C and ends at C with a distance less than 30' do
      let(:starting_node) { 'C' }
      let(:ending_node) { 'C' }
      let(:maximum_distance) { 30 }

      it { is_expected.to eq 7 }
    end
  end
end
