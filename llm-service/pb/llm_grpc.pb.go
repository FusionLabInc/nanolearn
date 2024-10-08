// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.5.1
// - protoc             v3.20.3
// source: llm.proto

package pb

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.64.0 or later.
const _ = grpc.SupportPackageIsVersion9

const (
	LlmService_GenerateNickname_FullMethodName = "/llm.LlmService/GenerateNickname"
	LlmService_NanoContent_FullMethodName      = "/llm.LlmService/NanoContent"
)

// LlmServiceClient is the client API for LlmService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type LlmServiceClient interface {
	GenerateNickname(ctx context.Context, opts ...grpc.CallOption) (grpc.BidiStreamingClient[GenerateNicknameRequest, GenerateNicknameResponse], error)
	NanoContent(ctx context.Context, opts ...grpc.CallOption) (grpc.ClientStreamingClient[NanoContentRequest, NanoContentResponse], error)
}

type llmServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewLlmServiceClient(cc grpc.ClientConnInterface) LlmServiceClient {
	return &llmServiceClient{cc}
}

func (c *llmServiceClient) GenerateNickname(ctx context.Context, opts ...grpc.CallOption) (grpc.BidiStreamingClient[GenerateNicknameRequest, GenerateNicknameResponse], error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	stream, err := c.cc.NewStream(ctx, &LlmService_ServiceDesc.Streams[0], LlmService_GenerateNickname_FullMethodName, cOpts...)
	if err != nil {
		return nil, err
	}
	x := &grpc.GenericClientStream[GenerateNicknameRequest, GenerateNicknameResponse]{ClientStream: stream}
	return x, nil
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type LlmService_GenerateNicknameClient = grpc.BidiStreamingClient[GenerateNicknameRequest, GenerateNicknameResponse]

func (c *llmServiceClient) NanoContent(ctx context.Context, opts ...grpc.CallOption) (grpc.ClientStreamingClient[NanoContentRequest, NanoContentResponse], error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	stream, err := c.cc.NewStream(ctx, &LlmService_ServiceDesc.Streams[1], LlmService_NanoContent_FullMethodName, cOpts...)
	if err != nil {
		return nil, err
	}
	x := &grpc.GenericClientStream[NanoContentRequest, NanoContentResponse]{ClientStream: stream}
	return x, nil
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type LlmService_NanoContentClient = grpc.ClientStreamingClient[NanoContentRequest, NanoContentResponse]

// LlmServiceServer is the server API for LlmService service.
// All implementations must embed UnimplementedLlmServiceServer
// for forward compatibility.
type LlmServiceServer interface {
	GenerateNickname(grpc.BidiStreamingServer[GenerateNicknameRequest, GenerateNicknameResponse]) error
	NanoContent(grpc.ClientStreamingServer[NanoContentRequest, NanoContentResponse]) error
	mustEmbedUnimplementedLlmServiceServer()
}

// UnimplementedLlmServiceServer must be embedded to have
// forward compatible implementations.
//
// NOTE: this should be embedded by value instead of pointer to avoid a nil
// pointer dereference when methods are called.
type UnimplementedLlmServiceServer struct{}

func (UnimplementedLlmServiceServer) GenerateNickname(grpc.BidiStreamingServer[GenerateNicknameRequest, GenerateNicknameResponse]) error {
	return status.Errorf(codes.Unimplemented, "method GenerateNickname not implemented")
}
func (UnimplementedLlmServiceServer) NanoContent(grpc.ClientStreamingServer[NanoContentRequest, NanoContentResponse]) error {
	return status.Errorf(codes.Unimplemented, "method NanoContent not implemented")
}
func (UnimplementedLlmServiceServer) mustEmbedUnimplementedLlmServiceServer() {}
func (UnimplementedLlmServiceServer) testEmbeddedByValue()                    {}

// UnsafeLlmServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to LlmServiceServer will
// result in compilation errors.
type UnsafeLlmServiceServer interface {
	mustEmbedUnimplementedLlmServiceServer()
}

func RegisterLlmServiceServer(s grpc.ServiceRegistrar, srv LlmServiceServer) {
	// If the following call pancis, it indicates UnimplementedLlmServiceServer was
	// embedded by pointer and is nil.  This will cause panics if an
	// unimplemented method is ever invoked, so we test this at initialization
	// time to prevent it from happening at runtime later due to I/O.
	if t, ok := srv.(interface{ testEmbeddedByValue() }); ok {
		t.testEmbeddedByValue()
	}
	s.RegisterService(&LlmService_ServiceDesc, srv)
}

func _LlmService_GenerateNickname_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(LlmServiceServer).GenerateNickname(&grpc.GenericServerStream[GenerateNicknameRequest, GenerateNicknameResponse]{ServerStream: stream})
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type LlmService_GenerateNicknameServer = grpc.BidiStreamingServer[GenerateNicknameRequest, GenerateNicknameResponse]

func _LlmService_NanoContent_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(LlmServiceServer).NanoContent(&grpc.GenericServerStream[NanoContentRequest, NanoContentResponse]{ServerStream: stream})
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type LlmService_NanoContentServer = grpc.ClientStreamingServer[NanoContentRequest, NanoContentResponse]

// LlmService_ServiceDesc is the grpc.ServiceDesc for LlmService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var LlmService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "llm.LlmService",
	HandlerType: (*LlmServiceServer)(nil),
	Methods:     []grpc.MethodDesc{},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "GenerateNickname",
			Handler:       _LlmService_GenerateNickname_Handler,
			ServerStreams: true,
			ClientStreams: true,
		},
		{
			StreamName:    "NanoContent",
			Handler:       _LlmService_NanoContent_Handler,
			ClientStreams: true,
		},
	},
	Metadata: "llm.proto",
}
