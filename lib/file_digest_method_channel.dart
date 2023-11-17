import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'file_digest_platform_interface.dart';

/// An implementation of [FileDigestPlatform] that uses method channels.
class MethodChannelFileDigest extends FileDigestPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('file_digest');

  @override
  Future<String?> getDigest(Uint8List data) async {
    return await methodChannel.invokeMethod<String>('getDigest', [data]);
  }
}
