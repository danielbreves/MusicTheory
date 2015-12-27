Pod::Spec.new do |s|
  s.name         = File.basename(__FILE__, ".podspec")
  s.version      = %x(git describe --tags --abbrev=0).chomp.sub(/^v/, '')
  s.summary      = "A music theory library for Swift OS X and iOS apps"
  s.description  = <<-DESC
  MusicTheory provides objects to work with musical keys, notes, scales and chords. It can be used to generate a scale from a key or note symbol, or a chord from a key and a chord degree for example. You can also use it to translate a sequence of notes to a sequence of MIDI values.
DESC

  s.homepage         = "https://github.com/danielbreves/MusicTheory"
  s.license          = "LICENSE"
  s.author           = { "Daniel Breves" => "djbreves@gmail.com" }
  s.social_media_url = "http://twitter.com/danielbreves"

  s.source       = { :git => "https://github.com/danielbreves/MusicTheory.git", :tag => "v#{s.version.to_s}" }
  s.source_files = "MusicTheory/**/*.swift"
  s.module_name  = "MusicTheory"

  s.ios.deployment_target     = "8.0"
  s.osx.deployment_target     = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target    = "9.0"

  s.dependency "STRegex", "~> 0.3"
end
