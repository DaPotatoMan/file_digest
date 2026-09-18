import 'package:file_digest/src/types.dart';

/// Throws because file digests are unavailable on this platform.
Future<String> convert(DigestType type, FileStreamReader openRead) {
  throw UnsupportedError('File digests are not supported on this platform.');
}
