part of 'misskey_adapter.dart';

Post toPost(MisskeyNote source) {
  assert(source != null);

  var mappedEmoji = source.emojis.map(toEmoji);

  return Post(
    source: source,
    postedAt: source.createdAt,
    author: toUser(source.user),
    liked: false,
    repeated: false,
    content: source.text,
    emojis: mappedEmoji,
    reactions: source.reactions.entries.map(
      (mkr) {
        return Reaction(
          count: mkr.value,
          includesMe: false,
          users: [],
          emoji: getEmojiFromString(mkr.key, mappedEmoji),
        );
      },
    ),
    attachments: source.files.map(toAttachment),
  );
}

Attachment toAttachment(MisskeyFile file) {
  print(file.url);
  return Attachment(
    source: file,
    type: "image",
    description: file.name,
    previewUrl: file.url,
    url: file.url,
  );
}

Emoji getEmojiFromString(String emojiString, Iterable<Emoji> inheritingEmoji) {
  if (emojiString.startsWith(":") && emojiString.endsWith(":")) {
    var matchingEmoji = inheritingEmoji.firstWhere(
        (e) => e.name == emojiString.substring(1, emojiString.length - 1));

    return matchingEmoji;
  }

  return UnicodeEmoji(emojiString, null, aliases: null);
}

CustomEmoji toEmoji(MisskeyEmoji emoji) {
  return CustomEmoji(
    source: emoji,
    name: emoji.name,
    url: emoji.url,
    aliases: emoji.aliases,
  );
}

User toUser(MisskeyUser source) {
  assert(source != null);

  return User(
    source: source,
    username: source.username,
    displayName: source.name ?? source.username,
    joinDate: source.createdAt,
    emojis: source.emojis.map(toEmoji),
    avatarUrl: source.avatarUrl,
    bannerUrl: source.bannerUrl,
    id: source.id,
    description: source.description,
  );
}
