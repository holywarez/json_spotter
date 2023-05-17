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

  context 'when json has books' do
    let(:json) { SampleJsonFactory.books_sample(authors: 2, books: 10) }

    it 'is empty by default' do
      expect(subject.any?).to be_falsey
    end

    context 'when book titles are expected' do
      let(:query) do
        {
          authors: [
            {
              books: [
                {
                  '$select' => {
                    'book_name' => 'title'
                  }
                }
              ]
            }
          ]
        }
      end

      it 'renders the list of book_titles' do
        expect(subject.to_a).to include('book_name' => be).and(have_attributes(size: 20))
      end
    end
  end
end
