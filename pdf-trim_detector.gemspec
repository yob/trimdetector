Gem::Specification.new do |s|
  s.name              = "pdf-trim_detector"
  s.version           = "0.1.0"
  s.summary           = "Attempt to detect the region of a PDF page indicated by trim marks"
  s.description       = "Attempt to detect the region of a PDF page indicated by trim marks"
  s.author            = "James Healy"
  s.email             = ["james@yob.id.au"]
  #s.homepage          = "http://github.com/yob/pdf-preflight"
  s.has_rdoc          = true
  s.rdoc_options      << "--title" << "PDF::TrimDetector" << "--line-numbers"
  s.files             = Dir.glob("lib/**/*") + Dir.glob("bin/*") + ["README.markdown", "CHANGELOG"]
  s.required_rubygems_version = ">=1.3.2"
  s.required_ruby_version = ">=1.8.7"

  s.add_dependency("pdf-reader", ">=1.1.0")

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec",   "~>2.3")
end
