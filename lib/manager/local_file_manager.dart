import 'dart:io';

import 'package:auto_novel_reader_flutter/manager/path_manager.dart';
import 'package:auto_novel_reader_flutter/util/file_util.dart';

final localFileManager = _LocalFileManager();

class _LocalFileManager {
  _LocalFileManager();

  Future<void> init() async {
    await pathManager.init();
    await Future.wait([
      initEpubDownloadDir(),
    ]);
  }

  Future<void> initEpubDownloadDir() async {
    final path = pathManager.epubDownloadPath;
    createDirectoryIfNotExists(path);
  }

  Future<void> cleanDownloadDir() async {
    final path = pathManager.epubDownloadPath;
    await deleteDirectory(path);
  }
}
