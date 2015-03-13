Pod::Spec.new do |spec|
    spec.name         = 'TTTabBar'
    spec.version      = '1.0'
    spec.license      = { :type => 'MIT' }
    spec.homepage     = 'https://github.com/Edig/TTTabBar'
    spec.authors      = { 'Eduardo Iglesias' => 'edig50@gmail.com' }
    spec.summary      = 'TabBar with small icons like Facebook'
    spec.source       = { :git => 'https://github.com/Edig/TTTabBar.git', :tag => 'v1.0' }
    spec.source_files = 'TTTabBar/*'
    spec.framework    = 'UIKit'
end