import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:downloadsfolder/downloadsfolder.dart';

final pathManager = _PathManager();

class _PathManager {
  late String externalStorageDirectory;
  late String downloadsDirectory;

  final _epubDownloadPath = '/epub';
  final _loggerPath = '/log';

  _PathManager();

  Future<void> init() async {
    final [dir1, dir2] = await Future.wait([getExternalStorageDirectory(), getDownloadDirectory()]);
    if (dir1 == null || dir2 == null) throw Exception('init path manager error');
    externalStorageDirectory = dir1.path;
    downloadsDirectory = dir2.path;
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

  /// downloadsDirectory/epub
  String get epubDownloadPath => downloadsDirectory + _epubDownloadPath;

  String get loggerPath => externalStorageDirectory + _loggerPath;
}
