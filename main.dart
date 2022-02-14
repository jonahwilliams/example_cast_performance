// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

import 'dart:ui' as ui show window;
import 'package:flutter/material.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  ui.window.onPointerDataPacket = null;

  var root = MediaQuery.fromWindow(
      child: Directionality(
    textDirection: TextDirection.ltr,
    child: Material(
      child: Column(
        children: List<Widget>.generate(9, (index) {
          return ListTile(
              leading: CircleAvatar(child: Text(index.toString())),
              title: Text('Content $index'));
        }),
      ),
    ),
  ));
  print('starting....');
  var results = [];
  for (var i = 0; i < 10; i++) {
    var sw = Stopwatch()..start();
    for (var count = 0; count < 1000; count++) {
      var renderViewElement = RenderObjectToWidgetAdapter(container: binding.renderView, child: root)
        .attachToRenderTree(binding.buildOwner!, null);
    }
    sw.stop();
    print('${i + 1} / 10');
    results.add(sw.elapsedMilliseconds);
  }
  print(results);
}
