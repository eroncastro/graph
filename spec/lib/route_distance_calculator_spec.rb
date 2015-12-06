require_relative '../../models/graph.rb'
require_relative '../../lib/route_distance_calculator.rb'

RSpec.describe RouteDistanceCalculator do
  let(:input) { 'spec/fixtures/input.txt' }
  let(:graph) { Graph.new(input) }
  let(:instance) { described_class.new(graph) }

  describe '#distance' do
    let(:error_message) { 'NO SUCH ROUTE' }
    subject(:distance) { instance.distance(route) }

    context 'when route corresponds to an empty array' do
      let(:route) { [] }

      it { is_expected.to eq(error_message) }
    end

    context 'when route corresponds to A' do
      let(:route) { %w(A) }

      it { is_expected.to eq(error_message) }
    end

    context 'when route corresponds to A-A' do
      let(:route) { %w(A A) }

      it { is_expected.to eq(error_message) }
    end

    context 'when route corresponds to A-B-C' do
      let(:route) { %w(A B C) }

      it { is_expected.to eq 9 }
    end

    context 'when route corresponds to A-D' do
      let(:route) { %w(A D) }

      it { is_expected.to eq 5 }
    end

    context 'when route corresponds to A-D-C' do
      let(:route) { %w(A D C) }

      it { is_expected.to eq 13 }
    end

    context 'when route corresponds to A-E-B-C-D' do
      let(:route) { %w(A E B C D) }

      it { is_expected.to eq 22 }
    end

    context 'when route corresponds to A-E-D' do
      let(:route) { %w(A E D) }

      it { is_expected.to eq error_message }
    end
  end
end
