// Records are just like functions but it can return multiple values.

import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const DocumentApp());
}

class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: DocumentScreen(document: Document()),
    );
  }
}

class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({required this.document, super.key});
  @override
  Widget build(BuildContext context) {
    final (title, modified: modified) = document.metadata;
    final blocks = document.getBlocks();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Text('Last modified: $modified'), // Modify from here
          Expanded(
            child: ListView.builder(
              itemCount: blocks.length,
              itemBuilder: (context, index) {
                return BlockWidget(block: blocks[index]);
              },
            ),
          ), // to here.
        ],
      ),
    );
  }
}

class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({required this.block, super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;
    switch (block.type) {
      case 'h1':
        textStyle = Theme.of(context).textTheme.displayMedium;
      case 'p' || 'checkbox':
        textStyle = Theme.of(context).textTheme.bodyMedium;
      case _:
        textStyle = Theme.of(context).textTheme.bodySmall;
    }

    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(block.text, style: textStyle),
    );
  }
}
