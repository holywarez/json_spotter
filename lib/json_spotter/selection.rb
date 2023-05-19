# frozen_string_literal: true

module JsonSpotter
  class Selection
    include Enumerable

    class Node < Struct.new(:parent, :reference, :value, keyword_init: true)
      attr_reader :parent, :reference, :value, :last_key

      def initialize(parent: nil, reference: nil, value: nil)
        @parent = parent
        @reference = reference
        @value = value
      end

      def on_subitem(key = nil)
        @last_key = key
      end

      def root?
        parent.nil?
      end

      def inspect
        "#{parent.inspect} -> #{self.class.name}(#{reference})"
      end
    end

    class ArrayNode < Node
      def initialize(...)
        super(...)
        @last_key = -1
      end

      def on_subitem(_ = nil)
        @last_key += 1
      end
    end

    class ObjectNode < Node
    end

    class ValueNode < Node
      def on_subitem(key = nil)
        # ignore
      end
    end

    def initialize(stream, query:, stream_processor:)
      @stream = stream
      @query = query
      @stream_processor = stream_processor
    end

    def each(&block)
      return to_enum unless block_given?

      setup_handlers(&block)

      while @stream.open?
        part = @stream.read
        @stream_processor << part unless part.nil?
      end
    end

    private

    def setup_handlers(&block)
      @current = nil

      @stream_processor.start_array do
        parent = @current
        @current = ArrayNode.new(parent: parent, reference: reference_for(parent))
      end

      @stream_processor.end_array do
        @current = @current&.parent
      end

      @stream_processor.key do |key_name|
        parent = @current
        parent&.on_subitem(key_name)
      end

      @stream_processor.value do |value|
        puts ValueNode.new(parent: @current, reference: reference_for(@current), value: value).inspect
      end

      @stream_processor.start_object do
        parent = @current
        @current = ObjectNode.new(parent: parent, reference: reference_for(parent))
      end

      @stream_processor.end_object do
        @current = @current&.parent
      end
    end

    def reference_for(node)
      case node
      when ArrayNode
        node.on_subitem
      when ObjectNode
        node.last_key
      else
        nil
      end
    end
  end
end
