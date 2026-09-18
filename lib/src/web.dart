import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' deferred as crypto;
import 'package:file_digest/src/types.dart';
import 'package:web/web.dart' as web;

Future<String> convert(DigestType type, FileStreamReader openRead) async {
  if (type == .md5) {
    await crypto.loadLibrary();
    return (await crypto.md5.bind(openRead()).first).toString();
  }

  const pkgName = 'file_digest';
  final workerUrl = Uri.base.resolve('assets/packages/$pkgName/assets/worker.js');
  final data = Uint8List.fromList(await openRead().expand((chunk) => chunk).toList());

  final worker = web.Worker(
    workerUrl.toString().toJS,
    web.WorkerOptions(type: 'module', name: pkgName),
  );

  try {
    final digest = Completer<String>();

    worker
      ..addEventListener(
        'message',
        (web.MessageEvent event) {
          final response = event.data.dartify();

          if (response is String && !digest.isCompleted) {
            digest.complete(response);
          } else if (response is Map && response['error'] is String && !digest.isCompleted) {
            digest.completeError(StateError(response['error'] as String));
          }
        }.toJS,
      )
      ..addEventListener(
        'error',
        (web.ErrorEvent event) {
          if (!digest.isCompleted) {
            digest.completeError(StateError(event.message));
          }
        }.toJS,
      )
      ..postMessage({'type': type.label, 'data': data}.jsify(), [data.buffer.toJS].toJS);

    return await digest.future;
  } finally {
    worker.terminate();
  }
}
