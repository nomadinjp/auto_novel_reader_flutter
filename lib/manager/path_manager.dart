import 'dart:io';

import 'package:path_provider/path_provider.dart';

final pathManager = _PathManager();

class _PathManager {
  late String externalStorageDirectory;

  final _epubDownloadPath = '/downloads/epub';
  final _loggerPath = '/log';

  _PathManager();

  Future<void> init() async {
    await _getExternalStorageDirectory();
  }

  Future<void> _getExternalStorageDirectory() async {
    final directory = await getExternalStorageDirectory();
    if (directory == null) throw Exception('no external storage');
    externalStorageDirectory = directory.path;
  }

  List<String> getLogPathList() {
    Directory directory = Directory(loggerPath);
    List<FileSystemEntity> files = directory.listSync();

    // 过滤出 .log 文件
    List<FileSystemEntity> logFiles = files.where((file) {
      return file.path.endsWith('.log');
    }).toList();
    return logFiles.map((file) => file.path).toList();
  }

  /// externalStorageDirectory/downloads/epub
  String get epubDownloadPath => externalStorageDirectory + _epubDownloadPath;

  String get loggerPath => externalStorageDirectory + _loggerPath;
}
