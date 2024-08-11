proto:
	rm -f pb/*.pb.dart
	protoc --proto_path=lib/pb --dart_out=grpc:lib/pb lib/pb/*.proto
	
.PHONY: proto