import 'file_digest_platform_interface.dart';

class FileDigest {
  final getDigest = FileDigestPlatform.instance.getDigest;
}
