import 'package:json_annotation/json_annotation.dart';
import 'package:fediverse_objects/src/misskey/user.dart';
part 'following.g.dart';

@JsonSerializable()
class MisskeyFollowing {
  /// The unique identifier for this following.
  @JsonKey(name: 'id')
  final String id;
  
  /// The date that the following was created.
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  
  @JsonKey(name: 'followeeId')
  final String followeeId;
  
  /// The followee.
  @JsonKey(name: 'followee')
  final MisskeyUser followee;
  
  @JsonKey(name: 'followerId')
  final String followerId;
  
  /// The follower.
  @JsonKey(name: 'follower')
  final MisskeyUser follower;
  
  const MisskeyFollowing({
    required this.id,
    required this.createdAt,
    required this.followeeId,
    required this.followee,
    required this.followerId,
    required this.follower,
  });

  factory MisskeyFollowing.fromJson(Map<String, dynamic> json) => _$MisskeyFollowingFromJson(json);
  Map<String, dynamic> toJson() => _$MisskeyFollowingToJson(this);
}
