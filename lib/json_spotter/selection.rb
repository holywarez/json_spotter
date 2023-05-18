# frozen_string_literal: true

module JsonSpotter
  class Selection
    include Enumerable

    def initialize(stream, query:, stream_processor:)
      @stream = stream
      @query = query
      @stream_processor = stream_processor
    end

    def each(&block)
      return to_enum unless block_given?

      nil
    end
  end
end
