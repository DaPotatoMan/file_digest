import 'package:crypto/crypto.dart' as crypto;
import 'package:file_digest/src/types.dart';

/// Creates a digest from a byte stream on Dart VM platforms.
Future<String> convert(DigestType type, FileStreamReader openRead) async {
  final hash = switch (type) {
    .md5 => crypto.md5,
    .sha256 => crypto.sha256,
    .sha512 => crypto.sha512,
  };

  final result = await hash.bind(openRead()).first;
  return result.toString();
}
