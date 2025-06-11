// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:file_digest/core.dart';

class FileDigest extends FileDigestBase {
  final Future<Uint8List> Function() _getBytes;
  FileDigest.file(File file) : _getBytes = (() => file.readAsBytes());
  FileDigest.xFile(XFile file) : _getBytes = (() => file.readAsBytes());

  Future<String> getDigest(String type) async {
    final data = await _getBytes();

    if (data.buffer.lengthInBytes == 0) {
      throw 'data buffer has not data. Do not re-use FileDigest in web platform';
    }

    final digest = Completer<String>();
    final worker = html.Worker('./assets/packages/file_digest/assets/worker.js');

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
  md5() => getDigest('MD5');

  @override
  sha256() => getDigest('SHA-256');

  @override
  sha512() => getDigest('SHA-512');
}
