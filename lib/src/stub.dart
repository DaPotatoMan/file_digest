import 'package:file_digest/src/types.dart';

Future<String> convert(DigestType type, FileStreamReader openRead) {
  throw UnsupportedError('File digests are not supported on this platform.');
}
