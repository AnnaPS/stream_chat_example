import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_page.dart';

Future<void> main() async {
  const apiKey = 'x8qpka9b3m9c';
  const userToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiQW5uYVBTIn0.BgTH8ElePivj9wlRlxtwdvdTObBHOiTZu38olHIypXc';

  final client = StreamChatClient(apiKey, logLevel: Level.INFO);

  await client.connectUser(
      User(id: 'AnaPolo', extraData: {
        'image':
            'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmedium.com%2Fjet-set-digital%2Farchitecture-components-flutter-ft-restful-api-sqlite-dependency-injection-4b872463981a&psig=AOvVaw3QuQLEVFwX7S1nL-oX8rCe&ust=1617443044655000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJi4yoKj3-8CFQAAAAAdAAAAABAD'
      }),
      userToken);

  // create a channel with type 'messaging' and 'flutterChat'.
  // Channel are containers for holding messages between different members
  final channel = client.channel('messaging', id: 'flutterchat', extraData: {
    'name': 'Flutter chat',
    'image':
        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgithub.com%2Fflutter%2Fflutter%2Fissues%2F61780&psig=AOvVaw3QuQLEVFwX7S1nL-oX8rCe&ust=1617443044655000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJi4yoKj3-8CFQAAAAAdAAAAABAI'
  });

  // watch() is used to create and listen to the channel for updates.
  channel.watch();

  runApp(MyApp(client, channel));
}

class MyApp extends StatelessWidget {
  const MyApp(this.client, this.channel);

  final StreamChatClient client;
  final Channel channel;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.dark().copyWith(accentColor: Colors.amber);

    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          child: widget,
          client: client,
          streamChatThemeData: StreamChatThemeData.fromTheme(theme),
        );
      },
      home: StreamChannel(
        channel: channel,
        child: ChannelPage(),
      ),
    );
  }
}
