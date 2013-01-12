= PDF::TrimDetector

Attempts to detect the trim marks on a PDF page and returns a rectangle
describing the box they indicate. Useful for when you have a PDF with trim
marks drawn on the page but no matching page box (TrimBox, ArtBox, etc)

== Installation

  gem install pdf-trim_detector

== Usage

    require 'pdf-reader'
    require 'pdf/trim_detector'

    detector = PDF::TrimDetector.new

    PDF::Reader.open("somefile.pdf") do |pdf|
      pdf.pages.each do |page|
        page.walk(detector)
        puts detector.trim.inspect
      end
    end

== Licensing

This library is distributed under the terms of the MIT License. See the included file for
more detail.
