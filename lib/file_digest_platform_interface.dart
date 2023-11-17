import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'file_digest_method_channel.dart';

abstract class FileDigestPlatform extends PlatformInterface {
  /// Constructs a FileDigestPlatform.
  FileDigestPlatform() : super(token: _token);

  static final Object _token = Object();

  static FileDigestPlatform _instance = MethodChannelFileDigest();

  /// The default instance of [FileDigestPlatform] to use.
  ///
  /// Defaults to [MethodChannelFileDigest].
  static FileDigestPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FileDigestPlatform] when
  /// they register themselves.
  static set instance(FileDigestPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getDigest(Uint8List data) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
