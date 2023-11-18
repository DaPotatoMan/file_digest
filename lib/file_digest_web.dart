// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;

import 'package:file_digest/core.dart';

class FileDigest extends FileDigestBase {
  FileDigest(super.data);
  FileDigest.fromString(String content) : super.fromString(content);

  Future<String> getDigest(String type) {
    if (data.buffer.lengthInBytes == 0) {
      throw 'data buffer has not data. Do not re-use FileDigest in web platform';
    }

    final digest = Completer<String>();
    final worker =
        html.Worker('./assets/packages/file_digest/assets/worker.js');

    worker.addEventListener('message', (event) {
      event = event as html.MessageEvent;

      if (event.data is String) {
        digest.complete(event.data);
        worker.terminate();
      }
    });

    worker.postMessage({'type': type, 'data': data}, [data.buffer]);

    return digest.future;
  }

  @override
  sha256() => getDigest('SHA-256');

  @override
  sha512() => getDigest('SHA-512');
}
