import 'dart:async';

import 'package:file_digest/file_digest.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const input = 'Test content';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<({String sha256, String sha512})> getDigests() async {
    return (
      sha256: await FileDigest.fromString(input).sha256(),
      sha512: await FileDigest.fromString(input).sha512(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: SizedBox(
            width: 400,
            child: FutureBuilder(
              future: getDigests(),
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null) {
                  return const CircularProgressIndicator();
                }

                const textStyle = (
                  label: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  value: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('SHA-256', style: textStyle.label),
                    Text(data.sha256, style: textStyle.value),
                    const SizedBox(height: 20),
                    Text('SHA-512', style: textStyle.label),
                    Text(data.sha512, style: textStyle.value),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
