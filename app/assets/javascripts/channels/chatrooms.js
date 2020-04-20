(function () {
  App.chatrooms = App.cable.subscriptions.create("ChatroomsChannel", {
    connected: function () {},
    disconnected: function () {},
    received: function (data) {
      var active_chatroom;
      active_chatroom = $(
        "[data-behavior='messages'][data-chatroom-id='" +
          data.chatroom_id +
          "']"
      );
      if (active_chatroom.length > 0) {
        return active_chatroom.append(data.message);
      } else {
        return $(
          "[data-behavior='chatroom-link'][data-chatroom-id='" +
            data.chatroom_id +
            "']"
        ).css("font-weight", "bold");
      }
    },
    send_message: function (chatroom_id, message) {
      return this.perform("send_message", {
        chatroom_id: chatroom_id,
        body: message,
      });
    },
  });
}.call(this));
