// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_subscription_alerts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonPushSubscriptionAlerts _$MastodonPushSubscriptionAlertsFromJson(
    Map<String, dynamic> json) {
  return MastodonPushSubscriptionAlerts(
    favourite: json['favourite'] as bool,
    follow: json['follow'] as bool,
    mention: json['mention'] as bool,
    poll: json['poll'] as bool,
    reblog: json['reblog'] as bool,
  );
}

Map<String, dynamic> _$MastodonPushSubscriptionAlertsToJson(
        MastodonPushSubscriptionAlerts instance) =>
    <String, dynamic>{
      'favourite': instance.favourite,
      'follow': instance.follow,
      'mention': instance.mention,
      'poll': instance.poll,
      'reblog': instance.reblog,
    };
