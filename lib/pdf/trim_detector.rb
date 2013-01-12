# coding: utf-8

require 'forwardable'
require 'bigdecimal'

module PDF

  # attempts to detect the trim marks on a PDF page and returns a rectangle
  # describing the box they indicate. Useful for when you have a PDF with trim
  # marks drawn on the page but no matching page box (TrimBox, ArtBox, etc)
  #
  # See the project README for a usage overview.
  #
  class TrimDetector
    extend Forwardable

    ########## BEGIN FORWARDERS ##########
    # Graphics State Operators
    def_delegators :@state, :save_graphics_state, :restore_graphics_state

    # Matrix Operators
    def_delegators :@state, :concatenate_matrix

    def page=(page)
      @page  = page
      @state = PDF::Reader::PageState.new(page)
      @paths = []
      @trim  = nil
      @current_paths = []
    end

    def trim
      xes = outer_x_candidates
      yes = outer_y_candidates
      if xes.size == 2 && yes.size == 2
        [
          xes.sort.first,
          yes.sort.first,
          xes.sort.last,
          yes.sort.last,
        ]
      end
    end

    def begin_new_subpath(x, y) # m
      @current_paths << Path.new
      x, y = @state.ctm_transform(x, y)
      @current_paths.last.add_point(x, y)
    end

    def append_line(x, y) # l
      if @current_paths.last
        x, y = @state.ctm_transform(x, y)
        @current_paths.last.add_point(x, y)
      end
    end

    def fill_stroke # B
      # TODO set the path colour
      while path = @current_paths.shift
        @paths << path
      end
    end

    def stroke_path # S
      # TODO set the path colour
      while path = @current_paths.shift
        @paths << path
      end
    end

    private

    def horizontal_paths
      @paths.select(&:horizontal?)
    end

    def vertical_paths
      @paths.select(&:vertical?)
    end

    def grouped_vertical_paths
      vertical_paths.group_by { |path| path.start.x }
    end

    def grouped_horizontal_paths
      horizontal_paths.group_by { |path| path.start.y }
    end

    def x_with_two_paths
      grouped_vertical_paths.map { |x, paths|
        paths.size >= 2 ? x : nil
      }.compact.sort
    end

    def y_with_two_paths
      grouped_horizontal_paths.map { |y, paths|
        paths.size >= 2 ? y : nil
      }.compact.sort
    end

    def outer_x_candidates
      xes = x_with_two_paths
      if xes.size >= 2
        [xes.first, xes.last]
      else
        xes
      end
    end

    def outer_y_candidates
      yes = y_with_two_paths
      if yes.size >= 2
        [yes.first, yes.last]
      else
        yes
      end
    end

    class Point
      attr_reader :x, :y

      def initialize(x, y)
        @x = BigDecimal.new(x.to_s).round(1)
        @y = BigDecimal.new(y.to_s).round(1)
      end
    end

    class Path

      def initialize
        @points = []
      end

      def start
        @points.first
      end

      def add_point(x, y)
        @points << Point.new(x, y)
      end

      def horizontal?
        @points.size == 2 && y_points.uniq.size == 1
      end

      def vertical?
        @points.size == 2 && x_points.uniq.size == 1
      end

      private

      def x_points
        @points.map { |point| point.x}
      end

      def y_points
        @points.map { |point| point.y}
      end
    end
  end
end
