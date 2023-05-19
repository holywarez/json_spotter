# frozen_string_literal: true

require 'stringio'

class SampleJsonStream < StringIO
  def initialize(json, chunk_size: 10)
    super(json, 'r')
    @chunk_size = chunk_size
    @closed = false
  end

  def read
    chunk = super(@chunk_size)
    @closed = chunk.nil?
    chunk
  end

  def open?
    !@closed && !closed_read?
  end
end
