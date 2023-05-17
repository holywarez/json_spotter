# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JsonSpotter::Selection do
  subject(:selection) { JsonSpotter::Selection.new(stream, query: query) }

  let(:query) { {} }
  let(:json) { '{}' }
  let(:stream) { SampleJsonStream.new(json) }

  context 'when json is blank' do
    subject { selection.any? }

    it { is_expected.to be_falsey }
  end
end
