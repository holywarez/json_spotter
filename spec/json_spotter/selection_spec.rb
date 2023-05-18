# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JsonSpotter::Selection do
  subject(:selection) { JsonSpotter::Selection.new(stream, query: query) }

  let(:query) { }
  let(:json) { '{}' }
  let(:stream) { SampleJsonStream.new(json) }

  context 'when json is blank' do
    subject { selection.any? }

    it { is_expected.to be_falsey }
  end

  context 'when json has books' do
    subject { selection.to_a }
    let(:json) { SampleJsonFactory.books_sample(authors: 2, books: 10) }

    context 'when blank json' do
      subject { selection.any? }

      it { is_expected.to be_falsey }
    end

    context 'when json path is used' do
      let(:query) { JsonSpotter::JsonPathQuery.new(json_path) }
      let(:json_path) {}

      context 'when book titles are expected' do
        let(:json_path) { '$.authors[*].books[*].title' }

        it { is_expected.to have_attributes(size: 20) }
      end

      context 'when book titles and authors are expected' do
        let(:json_path) { '$.authors[*].books[*]' }

        it { is_expected.to a_collection_including(a_hash_including(title: be, isbn13: be)) }
      end
    end
  end
end
