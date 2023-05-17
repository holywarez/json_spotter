# frozen_string_literal: true

module JsonSpotter
  class Selection
    include Enumerable

    def initialize(stream, query:)
      @stream = stream
      @query = query
    end

    def each(&block)
      return to_enum unless block_given?

      nil
    end
  end
end
