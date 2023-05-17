# frozen_string_literal: true

require 'stringio'

class SampleJsonStream < StringIO
  def initialize(json, chunk_size = 10)
    super(json, 'r')
    @chunk_size = chunk_size
  end

  def read
    super(@chunk_size)
  end
end
