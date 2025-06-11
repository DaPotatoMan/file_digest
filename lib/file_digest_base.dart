import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:file_digest/core.dart';

class FileDigest extends FileDigestBase {
  final Stream<List<int>> stream;
  FileDigest(this.stream);
  FileDigest.file(File file) : stream = file.openRead();
  FileDigest.xFile(XFile file) : stream = file.openRead();

  Future<String> _convert(crypto.Hash hash) {
    return hash.bind(stream).first.then((digest) => digest.toString());
  }

  @override
  md5() => _convert(crypto.md5);

  @override
  sha256() => _convert(crypto.sha256);

  @override
  sha512() => _convert(crypto.sha512);
}
