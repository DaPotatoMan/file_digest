import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class FileDigest {
  static Future<String> getDigest(Uint8List data) async {
    return Isolate.run(() => sha256.convert(data).toString());
  }
}
