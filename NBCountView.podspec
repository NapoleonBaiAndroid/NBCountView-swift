
Pod::Spec.new do |s|

  s.name         = "NBCountView"
  s.version      = "1.0.0"
  s.summary      = "计数器视图,支持两种显示方式"
  s.homepage     = "https://github.com/NapoleonBaiAndroid/NBCountView-swift"
  s.license      = "MIT"
  s.author             = { "NapoleonBai" => "napoleonbaiandroid@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/NapoleonBaiAndroid/NBCountView-swift.git", :tag => "1.0.0" }
 s.source_files  = "NBCountView-swift", "NBCountView-swift/NBCountView/Views/**/*"     
 s.requires_arc = true
end
