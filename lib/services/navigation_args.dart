class MessagesArgs {
  final String userId;
  final bool history;

  MessagesArgs(this.userId, this.history);
}

class ConversationsArgs {
  final String orderType;

  ConversationsArgs(this.orderType);
}
