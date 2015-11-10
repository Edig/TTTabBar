Pod::Spec.new do |spec|
    spec.name                   = 'TTTabBar'
    spec.version                = '1.1.1'
    spec.license                = { :type => 'MIT' }
    spec.homepage               = 'https://github.com/Edig/TTTabBar'
    spec.authors                = { 'Eduardo Iglesias' => 'edig50@gmail.com' }
    spec.summary                = 'TabBar with small icons like Facebook'
    spec.source                 = { :git => 'https://github.com/Edig/TTTabBar.git', :tag => '1.1.1' }
    spec.source_files           = 'TTTabBar/*'
    spec.framework              = 'UIKit'
    spec.requires_arc           = true
    spec.ios.deployment_target  = "8.0"
end
