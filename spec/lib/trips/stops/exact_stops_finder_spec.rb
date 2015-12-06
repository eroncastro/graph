require_relative '../../../../lib/trips/stops/exact_stops_finder.rb'
require_relative '../../../../models/graph.rb'

RSpec.describe Trips::Stops::ExactStopsFinder do
  let(:input) { 'spec/fixtures/input.txt' }
  let(:graph) { Graph.new(input) }
  let(:instance) { described_class.new(args) }
  let(:args) do
    {
      graph: graph,
      starting_node: starting_node,
      ending_node: ending_node,
      maximum_stops: maximum_stops
    }
  end

  describe '#count_trips' do
    subject(:count_trips) { instance.count_trips }

    context 'when trip starts at C and ends at C with a maximum of 3 stops' do
      let(:starting_node) { 'A' }
      let(:ending_node) { 'C' }
      let(:maximum_stops) { 4 }

      it { is_expected.to eq 3 }
    end

    context 'when trip starts at A and ends at A with exactly 4 stops' do
      let(:starting_node) { 'A' }
      let(:ending_node) { 'A' }
      let(:maximum_stops) { 3 }

      it { is_expected.to eq 0 }
    end
  end
end
