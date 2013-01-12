# coding: utf-8

# some helper methods available to all specs
module TrimSpecHelper

  def pdf_spec_file(base)
    base_path = File.expand_path(File.dirname(__FILE__) + "/../pdfs")
    filename  = File.join(base_path, "#{base}.pdf")
    if File.file?(filename)
      return filename
    else
      raise ArgumentError, "#{filename} not found"
    end
  end

end
