// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

import 'guest_book_message.dart';
import 'src/widgets.dart';

class MessageContent extends StatefulWidget {
  const MessageContent({
    super.key,
    required this.addMessage,
    required this.messages,
  });

  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages;


  @override
  State<MessageContent> createState() => _MessageContentState();
}

class _MessageContentState extends State<MessageContent> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_MessageContentState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '메시지를 입력하세요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '메시지를 입력하지 않았습니다.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('보내기'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (var message in widget.messages)
          Message('${message.name}: ${message.message}'),
        const SizedBox(height: 8),
      ],
    );
  }
}
