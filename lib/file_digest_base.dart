import 'dart:isolate';

import 'package:crypto/crypto.dart' as crypto;
import 'package:file_digest/core.dart';

class FileDigest extends FileDigestBase {
  const FileDigest(super.data);
  FileDigest.fromString(String content) : super.fromString(content);

  Future<String> _convert(crypto.Hash hash) {
    return Isolate.run(() => hash.convert(data).toString());
  }

  @override
  sha256() => _convert(crypto.sha256);

  @override
  sha512() => _convert(crypto.sha512);
}
