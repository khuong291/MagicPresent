Pod::Spec.new do |s|
  s.name         = "MagicPresent"
  s.version      = "1.0"
  s.summary      = "A lightweight Swift wrapper for custom ViewController presentations on iOS"
  s.description  = <<-DESC
                    A lightweight Swift wrapper for custom ViewController presentations on iOS
                   DESC
  s.homepage     = "http://github.com/khuong291/MagicPresent"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Khuong Pham" => "dkhuong291@gmail.com" }
  s.social_media_url   = "http://twitter.com/khuong291"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/khuong291/MagicPresent.git", :tag => "1.0" }
  s.source_files = "MagicPresent", "MagicPresent/**/*.{h,m,swift}"
end