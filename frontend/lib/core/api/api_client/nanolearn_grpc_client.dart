import 'package:frontend/core/api/index.dart';
import 'package:frontend/pb/llm.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class NLGrpcClient {
  NLGrpcClient(this._apiConfig);

  final NanolearnApiConfig _apiConfig;

  ClientChannel nlChannel() {
    final llmServerUrlParts = _apiConfig.llmServerUrl.split(':');
    final host = llmServerUrlParts[0];
    final port = int.parse(llmServerUrlParts[1]);

    final ClientChannel channel = ClientChannel("http://localhost",
        port: 8080,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ));

    return channel;
  }

  LlmServiceClient nlLlmServiceClient() {
    var client = LlmServiceClient(nlChannel());
    return client;
  }
}
