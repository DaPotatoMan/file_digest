
import 'file_digest_platform_interface.dart';

class FileDigest {
  Future<String?> getPlatformVersion() {
    return FileDigestPlatform.instance.getPlatformVersion();
  }
}
