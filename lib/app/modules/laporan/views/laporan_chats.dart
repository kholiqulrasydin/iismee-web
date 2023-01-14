import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:iismee/app/modules/laporan/controllers/chats_controller.dart';

class IismeeChats extends GetView<ChatsController> {
  IismeeChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GetBuilder<ChatsController>(
            builder: (controller) => Chat(
                  theme: DefaultChatTheme(
                      inputTextColor: Colors.white,
                      inputTextCursorColor: Colors.white38,
                      inputBackgroundColor: Colors.blueAccent,
                      primaryColor: Colors.teal,
                      secondaryColor: Colors.amber,
                      inputMargin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      inputBorderRadius: BorderRadius.circular(15)
                      ),
                  messages: controller.messages.value,
                  onAttachmentPressed: () =>
                      controller.handleAttachmentPressed(context),
                  onMessageTap: controller.handleMessageTap,
                  onPreviewDataFetched: controller.handlePreviewDataFetched,
                  onSendPressed: controller.handleSendPressed,
                  showUserAvatars: true,
                  showUserNames: true,
                  user: controller.user,
                )),
      ),
    );
  }
}
