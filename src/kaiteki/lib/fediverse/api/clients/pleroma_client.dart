import 'package:fediverse_objects/pleroma.dart';
import 'package:kaiteki/fediverse/api/api_type.dart';
import 'package:kaiteki/fediverse/api/clients/mastodon_client.dart';
import 'package:kaiteki/fediverse/api/responses/pleroma/emoji_packs_response.dart';
import 'package:kaiteki/model/http_method.dart';

class PleromaClient extends MastodonClient {
  @override
  ApiType get type => ApiType.pleroma;

  Future<Iterable<PleromaChat>> getChats() async {
    return await sendJsonRequestMultiple(
      HttpMethod.get,
      "api/v1/pleroma/chats",
      (json) => PleromaChat.fromJson(json),
    );
  }

  Future<Iterable<PleromaChatMessage>> getChatMessages(String id) async {
    return await sendJsonRequestMultiple(
      HttpMethod.get,
      "api/v1/pleroma/chats/$id/messages",
      (j) => PleromaChatMessage.fromJson(j),
    );
  }

  Future<PleromaChatMessage> postChatMessage(String id, String message) async {
    return await sendJsonRequest(
      HttpMethod.post,
      "api/v1/pleroma/chats/$id/messages",
      (j) => PleromaChatMessage.fromJson(j),
      body: {"content": message},
    );
  }

  Future<void> react(String postId, String emoji) async {
    await sendJsonRequestWithoutResponse(
      HttpMethod.put,
      "/api/v1/pleroma/statuses/$postId/reactions/$emoji",
    );
  }

  Future<void> removeReaction(String postId, String emoji) async {
    await sendJsonRequestWithoutResponse(
      HttpMethod.delete,
      "/api/v1/pleroma/statuses/$postId/reactions/$emoji",
    );
  }

  Future<PleromaEmojiPacksResponse> getEmojiPacks() async {
    return await sendJsonRequest(
      HttpMethod.get,
      "/api/pleroma/emoji/packs",
      (json) => PleromaEmojiPacksResponse.fromJson(json),
    );
  }
}
