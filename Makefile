all:

release:
	flutter build apk --release --target-platform=android-arm64 --dart-define=API_BASE_URL=http://crud.netb.co.kr:9303  --dart-define=VERSION=$(version)

release-web:
	flutter build web --dart-define=API_BASE_URL=  --dart-define=VERSION=$(version)

deploy: release-web
	scp -r ./web root@dev.zkeep.space:/home/zkeep/back
