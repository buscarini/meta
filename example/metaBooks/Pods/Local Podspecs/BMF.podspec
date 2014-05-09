Pod::Spec.new do |s|
	s.name     = 'BMF'
	s.version  = '0.0.3'
	s.license  = 'MIT'
	s.summary  = 'Base modular framework for iOS & Mac apps'
	s.homepage = 'https://bitbucket.org/buscarini/bmf'
	s.authors  = { 'José Manuel Sánchez' => 'buscarini@gmail.com' }
	s.source   = { :git => 'ssh://git@bitbucket.org/buscarini/bmf.git', :tag => "0.0.3", :submodules => true }

	s.ios.deployment_target = '6.0'
	s.osx.deployment_target = '10.8'
	s.requires_arc = true	
	
	#sp.dependency 'CocoaLumberjack', '~>1.6.4'
	s.dependency 'CocoaLumberjack'
	s.dependency 'AFNetworking', '~> 2.2'
  s.dependency 'ReactiveCocoa', '~> 2.2.3'
  s.dependency 'Base32', '~> 1.0.2'
  s.dependency 'Base64', '~> 1.0.1'
  
	s.subspec "Core" do |core|
		# core.source_files = 'bmf/shared/*.{h,m}'
    
    # core.ios.source_files = 'bmf/ios/*.{h,m}'
    
#     core.osx.source_files = 'bmf/mac/*.{h,m}'
# core.exclude_files = 'bmf/shared/subspecs/**/*.{h,m}'
#   core.exclude_files = 'bmf/shared/subspecs/**/*.{h,m}'
# core.ios.exclude_files = 'bmf/ios/subspecs/**/*.{h,m}'
# core.osx.exclude_files = 'bmf/mac/subspecs/**/*.{h,m}'

    core.resources = 'bmf/**/*.{xib}'
    core.resource_bundle = { 'BMF' => 'bmf/**/*.{lproj,png,jpg}' }

    core.subspec "Base" do |s|
      s.source_files = 'bmf/shared/base/**/*.{h,m}'
      # s.ios.source_files = 'bmf/ios/base/**/*.{h,m}'
      # s.osx.source_files = 'bmf/mac/base/**/*.{h,m}'
    end
    
    core.subspec "Aspects" do |s|
      s.source_files = 'bmf/shared/aspects/**/*.{h,m}'
      s.ios.source_files = 'bmf/ios/aspects/**/*.{h,m}'
    end
    
    core.subspec "Activities" do |s|
      s.source_files = 'bmf/shared/activities/**/*.{h,m}'
      s.ios.source_files = 'bmf/ios/activities/**/*.{h,m}'
      s.osx.source_files = 'bmf/mac/activities/**/*.{h,m}'
    end
    
    core.subspec "Events" do |s|
      s.source_files = 'bmf/shared/events/**/*.{h,m}'
    end
    
    core.subspec "Behaviors" do |s|
      s.ios.source_files = 'bmf/ios/behaviors/**/*.{h,m}'
    end
    
    core.subspec "Categories" do |s|
      s.source_files = 'bmf/shared/categories/**/*.{h,m}'
      s.ios.source_files = 'bmf/ios/categories/**/*.{h,m}'
    end
    
    core.subspec "Conditions" do |s|
      s.source_files = 'bmf/shared/conditions/**/*.{h,m}'
      s.ios.source_files = 'bmf/ios/conditions/**/*.{h,m}'
    end
    
    core.subspec "Configurations" do |s|
      s.source_files = 'bmf/shared/configurations/**/*.{h,m}'
    end
    
    core.subspec "Data" do |s|
      s.source_files = 'bmf/shared/data/*.{h,m}'

      core.subspec "Data Sources" do |s|
        s.source_files = 'bmf/shared/data/data sources/**/*.{h,m}'
        s.ios.source_files = 'bmf/ios/data/data sources/**/*.{h,m}'
      end
      
      core.subspec "Data Stores" do |s|
        s.source_files = 'bmf/shared/data/data stores/**/*.{h,m}'
        s.ios.source_files = 'bmf/ios/data/data stores/**/*.{h,m}'
      end
      
      core.subspec "Operations" do |s|
        s.source_files = 'bmf/shared/data/operations/**/*.{h,m}'
        s.ios.source_files = 'bmf/ios/data/operations/**/*.{h,m}'
      end
      
      core.subspec "Loaders" do |s|
        s.source_files = 'bmf/shared/data/loaders/**/*.{h,m}'
      end

      core.subspec "Parsers" do |s|
        s.source_files = 'bmf/shared/data/parsers/**/*.{h,m}'
      end

      core.subspec "Serializers" do |s|
        s.source_files = 'bmf/shared/data/serializers/**/*.{h,m}'
      end

      core.subspec "Writers" do |s|
        s.source_files = 'bmf/shared/data/writers/**/*.{h,m}'
      end
    end
    
    core.subspec "Factories" do |s|
      s.source_files = 'bmf/shared/factories/**/*.{h,m}'
      s.ios.source_files = 'bmf/ios/factories/**/*.{h,m}'
    end
    
    core.subspec "ITOX" do |s|
      s.source_files = 'bmf/shared/itox/**/*.{h,m}'
    end
    
    core.subspec "Model" do |s|
      s.source_files = 'bmf/shared/model/**/*.{h,m}'
    end
    
    core.subspec "Nodes" do |s|
      s.source_files = 'bmf/shared/nodes/**/*.{h,m}'
    end
    
    core.subspec "Utils" do |s|
      s.source_files = 'bmf/shared/utils/**/*.{h,m}'
      s.ios.source_files = 'bmf/ios/utils/**/*.{h,m}'
    end
    
    core.subspec "Values" do |s|
      s.source_files = 'bmf/shared/values/**/*.{h,m}'
    end
    
    core.subspec "View Controllers" do |s|
      s.ios.source_files = 'bmf/ios/view controllers/**/*.{h,m}'
    end
    
    core.subspec "Views" do |s|
      s.ios.source_files = 'bmf/ios/views/*.{h,m}'
      
      core.subspec "Cell configuration" do |s|
        s.ios.source_files = 'bmf/ios/views/cell configuration/*.{h,m}'
      end

      core.subspec "Cell factory" do |s|
        s.ios.source_files = 'bmf/ios/views/cell factory/*.{h,m}'
      end
      
      core.subspec "Cells" do |s|
        s.ios.source_files = 'bmf/ios/views/cells/*.{h,m}'
      end
      
      core.subspec "View register" do |s|
        s.ios.source_files = 'bmf/ios/views/view register/*.{h,m}'
      end
    end
	end
	
	s.subspec "Sqlite" do |sqlite|
		sqlite.source_files = 'bmf/shared/subspecs/fmdb/**/*.{h,m}'
  	sqlite.ios.source_files = 'bmf/ios/subspecs/fmdb/**/*.{h,m}'
		sqlite.dependency 'FMDB', '~> 2.2'
	end
	
  s.subspec "CoreData" do |coredata|
    coredata.source_files = 'bmf/shared/subspecs/coredata/**/*.{h,m}'
    coredata.ios.source_files = 'bmf/ios/subspecs/coredata/**/*.{h,m}'
      
    coredata.dependency 'MagicalRecord', '~> 2.2'
  end
  
  s.subspec "Crashlytics" do |sp|
    sp.ios.source_files = 'bmf/ios/subspecs/crashlytics/**/*.{h,m}'
    sp.ios.framework = 'Crashlytics'
    sp.dependency 'CrashlyticsLumberjack'
  end
  
  s.subspec "Flurry" do |sp|
    sp.ios.source_files = 'bmf/ios/subspecs/flurry/**/*.{h,m}'
    sp.ios.framework = 'Flurry'
  end
  
end