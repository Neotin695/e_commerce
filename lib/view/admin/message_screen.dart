import 'package:flutter/material.dart';

import '../component/err_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ErrWidget(
        title: 'No internet connection',
        imageUrl: 'assets/icons/server_down.svg',
        child: Scaffold());
  }
}
