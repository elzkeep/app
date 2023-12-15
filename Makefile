all: export

build: dummy
	cd ios && xcodebuild build -scheme Runner -workspace Runner.xcworkspace  -sdk iphoneos -destination generic/platform=iOS

archive: build
	cd ios && xcodebuild archive -scheme Runner -workspace Runner.xcworkspace  -sdk iphoneos -destination generic/platform=iOS -archivePath ./build/Runner.xcarchive

export: archive
	cd ios && xcodebuild -exportArchive -archivePath ./build/Runner.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath ./build

deploy: export

clean:
	cd ios && xcodebuild clean

dummy:
