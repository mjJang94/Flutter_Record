// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:record/src/widgets.dart';


class JoinContent extends StatefulWidget {
  const JoinContent({
    super.key,
    required this.joinRoom,
    required this.roomId,
  });
  final FutureOr<void> Function(String roomId) joinRoom;
  final String roomId;

  @override
  State<JoinContent> createState() => _JoinContentState();
}

class _JoinContentState extends State<JoinContent> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_JoinContentState');
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
                      hintText: '입장할 방 번호를 입력하세요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '번호를 입력하지 않았습니다.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.joinRoom(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('입장'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
