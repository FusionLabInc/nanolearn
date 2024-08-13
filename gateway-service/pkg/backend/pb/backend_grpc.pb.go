// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.5.1
// - protoc             v3.20.3
// source: backend/pb/backend.proto

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
	BackendService_FetchSetupNicknamePool_FullMethodName = "/backend.BackendService/FetchSetupNicknamePool"
	BackendService_Login_FullMethodName                  = "/backend.BackendService/Login"
	BackendService_ValidateToken_FullMethodName          = "/backend.BackendService/ValidateToken"
	BackendService_RenewToken_FullMethodName             = "/backend.BackendService/RenewToken"
	BackendService_GetUserDetails_FullMethodName         = "/backend.BackendService/GetUserDetails"
	BackendService_UploadFile_FullMethodName             = "/backend.BackendService/UploadFile"
	BackendService_GetContentGlossary_FullMethodName     = "/backend.BackendService/GetContentGlossary"
	BackendService_GetContentSummaries_FullMethodName    = "/backend.BackendService/GetContentSummaries"
)

// BackendServiceClient is the client API for BackendService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type BackendServiceClient interface {
	FetchSetupNicknamePool(ctx context.Context, in *FetchSetupNicknamePoolRequest, opts ...grpc.CallOption) (*FetchSetupNicknamePoolResponse, error)
	Login(ctx context.Context, in *LoginRequest, opts ...grpc.CallOption) (*LoginResponse, error)
	ValidateToken(ctx context.Context, in *ValidateTokenRequest, opts ...grpc.CallOption) (*ValidateTokenResponse, error)
	RenewToken(ctx context.Context, in *RenewTokenRequest, opts ...grpc.CallOption) (*RenewTokenResponse, error)
	GetUserDetails(ctx context.Context, in *GetUserDetailsRequest, opts ...grpc.CallOption) (*GetUserDetailsResponse, error)
	UploadFile(ctx context.Context, opts ...grpc.CallOption) (grpc.ClientStreamingClient[FileUploadRequest, FileUploadResponse], error)
	GetContentGlossary(ctx context.Context, in *GetContentGlossaryRequest, opts ...grpc.CallOption) (*GetContentGlossaryResponse, error)
	GetContentSummaries(ctx context.Context, in *GetContentSummariesRequest, opts ...grpc.CallOption) (*GetContentSummariesResponse, error)
}

type backendServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewBackendServiceClient(cc grpc.ClientConnInterface) BackendServiceClient {
	return &backendServiceClient{cc}
}

func (c *backendServiceClient) FetchSetupNicknamePool(ctx context.Context, in *FetchSetupNicknamePoolRequest, opts ...grpc.CallOption) (*FetchSetupNicknamePoolResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(FetchSetupNicknamePoolResponse)
	err := c.cc.Invoke(ctx, BackendService_FetchSetupNicknamePool_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *backendServiceClient) Login(ctx context.Context, in *LoginRequest, opts ...grpc.CallOption) (*LoginResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(LoginResponse)
	err := c.cc.Invoke(ctx, BackendService_Login_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *backendServiceClient) ValidateToken(ctx context.Context, in *ValidateTokenRequest, opts ...grpc.CallOption) (*ValidateTokenResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(ValidateTokenResponse)
	err := c.cc.Invoke(ctx, BackendService_ValidateToken_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *backendServiceClient) RenewToken(ctx context.Context, in *RenewTokenRequest, opts ...grpc.CallOption) (*RenewTokenResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(RenewTokenResponse)
	err := c.cc.Invoke(ctx, BackendService_RenewToken_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *backendServiceClient) GetUserDetails(ctx context.Context, in *GetUserDetailsRequest, opts ...grpc.CallOption) (*GetUserDetailsResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(GetUserDetailsResponse)
	err := c.cc.Invoke(ctx, BackendService_GetUserDetails_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *backendServiceClient) UploadFile(ctx context.Context, opts ...grpc.CallOption) (grpc.ClientStreamingClient[FileUploadRequest, FileUploadResponse], error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	stream, err := c.cc.NewStream(ctx, &BackendService_ServiceDesc.Streams[0], BackendService_UploadFile_FullMethodName, cOpts...)
	if err != nil {
		return nil, err
	}
	x := &grpc.GenericClientStream[FileUploadRequest, FileUploadResponse]{ClientStream: stream}
	return x, nil
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type BackendService_UploadFileClient = grpc.ClientStreamingClient[FileUploadRequest, FileUploadResponse]

func (c *backendServiceClient) GetContentGlossary(ctx context.Context, in *GetContentGlossaryRequest, opts ...grpc.CallOption) (*GetContentGlossaryResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(GetContentGlossaryResponse)
	err := c.cc.Invoke(ctx, BackendService_GetContentGlossary_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *backendServiceClient) GetContentSummaries(ctx context.Context, in *GetContentSummariesRequest, opts ...grpc.CallOption) (*GetContentSummariesResponse, error) {
	cOpts := append([]grpc.CallOption{grpc.StaticMethod()}, opts...)
	out := new(GetContentSummariesResponse)
	err := c.cc.Invoke(ctx, BackendService_GetContentSummaries_FullMethodName, in, out, cOpts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// BackendServiceServer is the server API for BackendService service.
// All implementations must embed UnimplementedBackendServiceServer
// for forward compatibility.
type BackendServiceServer interface {
	FetchSetupNicknamePool(context.Context, *FetchSetupNicknamePoolRequest) (*FetchSetupNicknamePoolResponse, error)
	Login(context.Context, *LoginRequest) (*LoginResponse, error)
	ValidateToken(context.Context, *ValidateTokenRequest) (*ValidateTokenResponse, error)
	RenewToken(context.Context, *RenewTokenRequest) (*RenewTokenResponse, error)
	GetUserDetails(context.Context, *GetUserDetailsRequest) (*GetUserDetailsResponse, error)
	UploadFile(grpc.ClientStreamingServer[FileUploadRequest, FileUploadResponse]) error
	GetContentGlossary(context.Context, *GetContentGlossaryRequest) (*GetContentGlossaryResponse, error)
	GetContentSummaries(context.Context, *GetContentSummariesRequest) (*GetContentSummariesResponse, error)
	mustEmbedUnimplementedBackendServiceServer()
}

// UnimplementedBackendServiceServer must be embedded to have
// forward compatible implementations.
//
// NOTE: this should be embedded by value instead of pointer to avoid a nil
// pointer dereference when methods are called.
type UnimplementedBackendServiceServer struct{}

func (UnimplementedBackendServiceServer) FetchSetupNicknamePool(context.Context, *FetchSetupNicknamePoolRequest) (*FetchSetupNicknamePoolResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method FetchSetupNicknamePool not implemented")
}
func (UnimplementedBackendServiceServer) Login(context.Context, *LoginRequest) (*LoginResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Login not implemented")
}
func (UnimplementedBackendServiceServer) ValidateToken(context.Context, *ValidateTokenRequest) (*ValidateTokenResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method ValidateToken not implemented")
}
func (UnimplementedBackendServiceServer) RenewToken(context.Context, *RenewTokenRequest) (*RenewTokenResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method RenewToken not implemented")
}
func (UnimplementedBackendServiceServer) GetUserDetails(context.Context, *GetUserDetailsRequest) (*GetUserDetailsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetUserDetails not implemented")
}
func (UnimplementedBackendServiceServer) UploadFile(grpc.ClientStreamingServer[FileUploadRequest, FileUploadResponse]) error {
	return status.Errorf(codes.Unimplemented, "method UploadFile not implemented")
}
func (UnimplementedBackendServiceServer) GetContentGlossary(context.Context, *GetContentGlossaryRequest) (*GetContentGlossaryResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetContentGlossary not implemented")
}
func (UnimplementedBackendServiceServer) GetContentSummaries(context.Context, *GetContentSummariesRequest) (*GetContentSummariesResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetContentSummaries not implemented")
}
func (UnimplementedBackendServiceServer) mustEmbedUnimplementedBackendServiceServer() {}
func (UnimplementedBackendServiceServer) testEmbeddedByValue()                        {}

// UnsafeBackendServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to BackendServiceServer will
// result in compilation errors.
type UnsafeBackendServiceServer interface {
	mustEmbedUnimplementedBackendServiceServer()
}

func RegisterBackendServiceServer(s grpc.ServiceRegistrar, srv BackendServiceServer) {
	// If the following call pancis, it indicates UnimplementedBackendServiceServer was
	// embedded by pointer and is nil.  This will cause panics if an
	// unimplemented method is ever invoked, so we test this at initialization
	// time to prevent it from happening at runtime later due to I/O.
	if t, ok := srv.(interface{ testEmbeddedByValue() }); ok {
		t.testEmbeddedByValue()
	}
	s.RegisterService(&BackendService_ServiceDesc, srv)
}

func _BackendService_FetchSetupNicknamePool_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(FetchSetupNicknamePoolRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BackendServiceServer).FetchSetupNicknamePool(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: BackendService_FetchSetupNicknamePool_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BackendServiceServer).FetchSetupNicknamePool(ctx, req.(*FetchSetupNicknamePoolRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _BackendService_Login_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(LoginRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BackendServiceServer).Login(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: BackendService_Login_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BackendServiceServer).Login(ctx, req.(*LoginRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _BackendService_ValidateToken_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(ValidateTokenRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BackendServiceServer).ValidateToken(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: BackendService_ValidateToken_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BackendServiceServer).ValidateToken(ctx, req.(*ValidateTokenRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _BackendService_RenewToken_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(RenewTokenRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BackendServiceServer).RenewToken(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: BackendService_RenewToken_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BackendServiceServer).RenewToken(ctx, req.(*RenewTokenRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _BackendService_GetUserDetails_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetUserDetailsRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BackendServiceServer).GetUserDetails(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: BackendService_GetUserDetails_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BackendServiceServer).GetUserDetails(ctx, req.(*GetUserDetailsRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _BackendService_UploadFile_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(BackendServiceServer).UploadFile(&grpc.GenericServerStream[FileUploadRequest, FileUploadResponse]{ServerStream: stream})
}

// This type alias is provided for backwards compatibility with existing code that references the prior non-generic stream type by name.
type BackendService_UploadFileServer = grpc.ClientStreamingServer[FileUploadRequest, FileUploadResponse]

func _BackendService_GetContentGlossary_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetContentGlossaryRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BackendServiceServer).GetContentGlossary(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: BackendService_GetContentGlossary_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BackendServiceServer).GetContentGlossary(ctx, req.(*GetContentGlossaryRequest))
	}
	return interceptor(ctx, in, info, handler)
}

func _BackendService_GetContentSummaries_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(GetContentSummariesRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(BackendServiceServer).GetContentSummaries(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: BackendService_GetContentSummaries_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(BackendServiceServer).GetContentSummaries(ctx, req.(*GetContentSummariesRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// BackendService_ServiceDesc is the grpc.ServiceDesc for BackendService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var BackendService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "backend.BackendService",
	HandlerType: (*BackendServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "FetchSetupNicknamePool",
			Handler:    _BackendService_FetchSetupNicknamePool_Handler,
		},
		{
			MethodName: "Login",
			Handler:    _BackendService_Login_Handler,
		},
		{
			MethodName: "ValidateToken",
			Handler:    _BackendService_ValidateToken_Handler,
		},
		{
			MethodName: "RenewToken",
			Handler:    _BackendService_RenewToken_Handler,
		},
		{
			MethodName: "GetUserDetails",
			Handler:    _BackendService_GetUserDetails_Handler,
		},
		{
			MethodName: "GetContentGlossary",
			Handler:    _BackendService_GetContentGlossary_Handler,
		},
		{
			MethodName: "GetContentSummaries",
			Handler:    _BackendService_GetContentSummaries_Handler,
		},
	},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "UploadFile",
			Handler:       _BackendService_UploadFile_Handler,
			ClientStreams: true,
		},
	},
	Metadata: "backend/pb/backend.proto",
}
