# coding: utf-8

require 'spec_helper'

describe PDF::TrimDetector do
  context "with trim_marks.pdf" do
    let!(:detector) { PDF::TrimDetector.new}
    before do
      PDF::Reader.open(pdf_spec_file("trim_marks")) do |pdf|
        pdf.page(1).walk(detector)
      end
    end

    it "should detect the trim marks" do
      detector.trim.should == [0, 0, 100, 100]
    end
  end
end
