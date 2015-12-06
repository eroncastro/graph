require_relative '../../models/graph.rb'

RSpec.describe Graph do
  let(:input) { 'spec/fixtures/input.txt' }
  let(:instance) { described_class.new(input) }

  describe '#nodes' do
    let(:result) { %w(A B C D E) }
    subject(:nodes) { instance.nodes }

    it { is_expected.to match_array(result) }
  end

  describe '#edges' do
    let(:result) do
      {
        'A'=> {'B'=>5, 'D'=>5, 'E'=>7},
        'B'=>{'C'=>4},
        'C'=>{'D'=>8, 'E'=>2},
        'D'=>{'C'=>8, 'E'=>6},
        'E'=>{'B'=>3}
      }
    end
    subject(:edges) { instance.edges }

    it { is_expected.to eq(result) }
  end
end
