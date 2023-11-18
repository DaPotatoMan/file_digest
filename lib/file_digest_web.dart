import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

class FileDigest {
  static Future<String> getDigest(Uint8List data) async {
    final digest = Completer<String>();
    final worker = html.Worker('./assets/packages/file_digest/assets/worker.js');

    worker.addEventListener('message', (event) {
      event = event as html.MessageEvent;

      if (event.data is String) {
        digest.complete(event.data);
        worker.terminate();
      }
    });

    worker.postMessage(data);

    return digest.future;
  }
}
