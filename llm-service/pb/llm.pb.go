// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.34.2
// 	protoc        v3.20.3
// source: llm.proto

package pb

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type GenerateNicknameRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	SelectedNicknamesFromPool []string `protobuf:"bytes,1,rep,name=selectedNicknamesFromPool,proto3" json:"selectedNicknamesFromPool,omitempty"`
}

func (x *GenerateNicknameRequest) Reset() {
	*x = GenerateNicknameRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_llm_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *GenerateNicknameRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*GenerateNicknameRequest) ProtoMessage() {}

func (x *GenerateNicknameRequest) ProtoReflect() protoreflect.Message {
	mi := &file_llm_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use GenerateNicknameRequest.ProtoReflect.Descriptor instead.
func (*GenerateNicknameRequest) Descriptor() ([]byte, []int) {
	return file_llm_proto_rawDescGZIP(), []int{0}
}

func (x *GenerateNicknameRequest) GetSelectedNicknamesFromPool() []string {
	if x != nil {
		return x.SelectedNicknamesFromPool
	}
	return nil
}

type GenerateNicknameResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	Nickname string `protobuf:"bytes,1,opt,name=nickname,proto3" json:"nickname,omitempty"`
}

func (x *GenerateNicknameResponse) Reset() {
	*x = GenerateNicknameResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_llm_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *GenerateNicknameResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*GenerateNicknameResponse) ProtoMessage() {}

func (x *GenerateNicknameResponse) ProtoReflect() protoreflect.Message {
	mi := &file_llm_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use GenerateNicknameResponse.ProtoReflect.Descriptor instead.
func (*GenerateNicknameResponse) Descriptor() ([]byte, []int) {
	return file_llm_proto_rawDescGZIP(), []int{1}
}

func (x *GenerateNicknameResponse) GetNickname() string {
	if x != nil {
		return x.Nickname
	}
	return ""
}

type NanoContentRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	FileName string `protobuf:"bytes,1,opt,name=file_name,json=fileName,proto3" json:"file_name,omitempty"`
	Id       string `protobuf:"bytes,2,opt,name=id,proto3" json:"id,omitempty"`
	UserId   string `protobuf:"bytes,3,opt,name=user_id,json=userId,proto3" json:"user_id,omitempty"`
	Chunk    []byte `protobuf:"bytes,4,opt,name=chunk,proto3" json:"chunk,omitempty"`
}

func (x *NanoContentRequest) Reset() {
	*x = NanoContentRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_llm_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *NanoContentRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*NanoContentRequest) ProtoMessage() {}

func (x *NanoContentRequest) ProtoReflect() protoreflect.Message {
	mi := &file_llm_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use NanoContentRequest.ProtoReflect.Descriptor instead.
func (*NanoContentRequest) Descriptor() ([]byte, []int) {
	return file_llm_proto_rawDescGZIP(), []int{2}
}

func (x *NanoContentRequest) GetFileName() string {
	if x != nil {
		return x.FileName
	}
	return ""
}

func (x *NanoContentRequest) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *NanoContentRequest) GetUserId() string {
	if x != nil {
		return x.UserId
	}
	return ""
}

func (x *NanoContentRequest) GetChunk() []byte {
	if x != nil {
		return x.Chunk
	}
	return nil
}

type NanoContentResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	FileName string `protobuf:"bytes,1,opt,name=file_name,json=fileName,proto3" json:"file_name,omitempty"`
	Size     uint32 `protobuf:"varint,2,opt,name=size,proto3" json:"size,omitempty"`
}

func (x *NanoContentResponse) Reset() {
	*x = NanoContentResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_llm_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *NanoContentResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*NanoContentResponse) ProtoMessage() {}

func (x *NanoContentResponse) ProtoReflect() protoreflect.Message {
	mi := &file_llm_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use NanoContentResponse.ProtoReflect.Descriptor instead.
func (*NanoContentResponse) Descriptor() ([]byte, []int) {
	return file_llm_proto_rawDescGZIP(), []int{3}
}

func (x *NanoContentResponse) GetFileName() string {
	if x != nil {
		return x.FileName
	}
	return ""
}

func (x *NanoContentResponse) GetSize() uint32 {
	if x != nil {
		return x.Size
	}
	return 0
}

var File_llm_proto protoreflect.FileDescriptor

var file_llm_proto_rawDesc = []byte{
	0x0a, 0x09, 0x6c, 0x6c, 0x6d, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x03, 0x6c, 0x6c, 0x6d,
	0x22, 0x57, 0x0a, 0x17, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x74, 0x65, 0x4e, 0x69, 0x63, 0x6b,
	0x6e, 0x61, 0x6d, 0x65, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x3c, 0x0a, 0x19, 0x73,
	0x65, 0x6c, 0x65, 0x63, 0x74, 0x65, 0x64, 0x4e, 0x69, 0x63, 0x6b, 0x6e, 0x61, 0x6d, 0x65, 0x73,
	0x46, 0x72, 0x6f, 0x6d, 0x50, 0x6f, 0x6f, 0x6c, 0x18, 0x01, 0x20, 0x03, 0x28, 0x09, 0x52, 0x19,
	0x73, 0x65, 0x6c, 0x65, 0x63, 0x74, 0x65, 0x64, 0x4e, 0x69, 0x63, 0x6b, 0x6e, 0x61, 0x6d, 0x65,
	0x73, 0x46, 0x72, 0x6f, 0x6d, 0x50, 0x6f, 0x6f, 0x6c, 0x22, 0x36, 0x0a, 0x18, 0x47, 0x65, 0x6e,
	0x65, 0x72, 0x61, 0x74, 0x65, 0x4e, 0x69, 0x63, 0x6b, 0x6e, 0x61, 0x6d, 0x65, 0x52, 0x65, 0x73,
	0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x1a, 0x0a, 0x08, 0x6e, 0x69, 0x63, 0x6b, 0x6e, 0x61, 0x6d,
	0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x6e, 0x69, 0x63, 0x6b, 0x6e, 0x61, 0x6d,
	0x65, 0x22, 0x70, 0x0a, 0x12, 0x4e, 0x61, 0x6e, 0x6f, 0x43, 0x6f, 0x6e, 0x74, 0x65, 0x6e, 0x74,
	0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x1b, 0x0a, 0x09, 0x66, 0x69, 0x6c, 0x65, 0x5f,
	0x6e, 0x61, 0x6d, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x66, 0x69, 0x6c, 0x65,
	0x4e, 0x61, 0x6d, 0x65, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09,
	0x52, 0x02, 0x69, 0x64, 0x12, 0x17, 0x0a, 0x07, 0x75, 0x73, 0x65, 0x72, 0x5f, 0x69, 0x64, 0x18,
	0x03, 0x20, 0x01, 0x28, 0x09, 0x52, 0x06, 0x75, 0x73, 0x65, 0x72, 0x49, 0x64, 0x12, 0x14, 0x0a,
	0x05, 0x63, 0x68, 0x75, 0x6e, 0x6b, 0x18, 0x04, 0x20, 0x01, 0x28, 0x0c, 0x52, 0x05, 0x63, 0x68,
	0x75, 0x6e, 0x6b, 0x22, 0x46, 0x0a, 0x13, 0x4e, 0x61, 0x6e, 0x6f, 0x43, 0x6f, 0x6e, 0x74, 0x65,
	0x6e, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x1b, 0x0a, 0x09, 0x66, 0x69,
	0x6c, 0x65, 0x5f, 0x6e, 0x61, 0x6d, 0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x52, 0x08, 0x66,
	0x69, 0x6c, 0x65, 0x4e, 0x61, 0x6d, 0x65, 0x12, 0x12, 0x0a, 0x04, 0x73, 0x69, 0x7a, 0x65, 0x18,
	0x02, 0x20, 0x01, 0x28, 0x0d, 0x52, 0x04, 0x73, 0x69, 0x7a, 0x65, 0x32, 0xa7, 0x01, 0x0a, 0x0a,
	0x4c, 0x6c, 0x6d, 0x53, 0x65, 0x72, 0x76, 0x69, 0x63, 0x65, 0x12, 0x55, 0x0a, 0x10, 0x47, 0x65,
	0x6e, 0x65, 0x72, 0x61, 0x74, 0x65, 0x4e, 0x69, 0x63, 0x6b, 0x6e, 0x61, 0x6d, 0x65, 0x12, 0x1c,
	0x2e, 0x6c, 0x6c, 0x6d, 0x2e, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x74, 0x65, 0x4e, 0x69, 0x63,
	0x6b, 0x6e, 0x61, 0x6d, 0x65, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x1d, 0x2e, 0x6c,
	0x6c, 0x6d, 0x2e, 0x47, 0x65, 0x6e, 0x65, 0x72, 0x61, 0x74, 0x65, 0x4e, 0x69, 0x63, 0x6b, 0x6e,
	0x61, 0x6d, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x28, 0x01, 0x30,
	0x01, 0x12, 0x42, 0x0a, 0x0b, 0x4e, 0x61, 0x6e, 0x6f, 0x43, 0x6f, 0x6e, 0x74, 0x65, 0x6e, 0x74,
	0x12, 0x17, 0x2e, 0x6c, 0x6c, 0x6d, 0x2e, 0x4e, 0x61, 0x6e, 0x6f, 0x43, 0x6f, 0x6e, 0x74, 0x65,
	0x6e, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x18, 0x2e, 0x6c, 0x6c, 0x6d, 0x2e,
	0x4e, 0x61, 0x6e, 0x6f, 0x43, 0x6f, 0x6e, 0x74, 0x65, 0x6e, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f,
	0x6e, 0x73, 0x65, 0x28, 0x01, 0x42, 0x06, 0x5a, 0x04, 0x2e, 0x2f, 0x70, 0x62, 0x62, 0x06, 0x70,
	0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_llm_proto_rawDescOnce sync.Once
	file_llm_proto_rawDescData = file_llm_proto_rawDesc
)

func file_llm_proto_rawDescGZIP() []byte {
	file_llm_proto_rawDescOnce.Do(func() {
		file_llm_proto_rawDescData = protoimpl.X.CompressGZIP(file_llm_proto_rawDescData)
	})
	return file_llm_proto_rawDescData
}

var file_llm_proto_msgTypes = make([]protoimpl.MessageInfo, 4)
var file_llm_proto_goTypes = []any{
	(*GenerateNicknameRequest)(nil),  // 0: llm.GenerateNicknameRequest
	(*GenerateNicknameResponse)(nil), // 1: llm.GenerateNicknameResponse
	(*NanoContentRequest)(nil),       // 2: llm.NanoContentRequest
	(*NanoContentResponse)(nil),      // 3: llm.NanoContentResponse
}
var file_llm_proto_depIdxs = []int32{
	0, // 0: llm.LlmService.GenerateNickname:input_type -> llm.GenerateNicknameRequest
	2, // 1: llm.LlmService.NanoContent:input_type -> llm.NanoContentRequest
	1, // 2: llm.LlmService.GenerateNickname:output_type -> llm.GenerateNicknameResponse
	3, // 3: llm.LlmService.NanoContent:output_type -> llm.NanoContentResponse
	2, // [2:4] is the sub-list for method output_type
	0, // [0:2] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_llm_proto_init() }
func file_llm_proto_init() {
	if File_llm_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_llm_proto_msgTypes[0].Exporter = func(v any, i int) any {
			switch v := v.(*GenerateNicknameRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_llm_proto_msgTypes[1].Exporter = func(v any, i int) any {
			switch v := v.(*GenerateNicknameResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_llm_proto_msgTypes[2].Exporter = func(v any, i int) any {
			switch v := v.(*NanoContentRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_llm_proto_msgTypes[3].Exporter = func(v any, i int) any {
			switch v := v.(*NanoContentResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_llm_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   4,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_llm_proto_goTypes,
		DependencyIndexes: file_llm_proto_depIdxs,
		MessageInfos:      file_llm_proto_msgTypes,
	}.Build()
	File_llm_proto = out.File
	file_llm_proto_rawDesc = nil
	file_llm_proto_goTypes = nil
	file_llm_proto_depIdxs = nil
}
