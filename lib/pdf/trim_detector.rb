# coding: utf-8

module PDF

  # attempts to detect the trim marks on a PDF page and returns a rectangle
  # describing the box they indicate. Useful for when you have a PDF with trim
  # marks drawn on the page but no matching page box (TrimBox, ArtBox, etc)
  #
  # See the project README for a usage overview.
  #
  class TrimDetector

    attr_reader :trim

    def page=(page)
      @page = page
      @trim = nil
    end

  end
end
