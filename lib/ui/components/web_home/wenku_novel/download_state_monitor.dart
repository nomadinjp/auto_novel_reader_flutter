import 'package:auto_novel_reader_flutter/bloc/download_cubit/download_cubit.dart';
import 'package:auto_novel_reader_flutter/manager/style_manager.dart';
import 'package:auto_novel_reader_flutter/model/enums.dart';
import 'package:auto_novel_reader_flutter/ui/components/universal/line_button.dart';
import 'package:auto_novel_reader_flutter/util/client_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

class DownloadStateMonitor extends StatelessWidget {
  const DownloadStateMonitor({
    super.key,
    required this.filename,
    required this.onPressed,
  });

  final String filename;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      child: Center(
        child: BlocSelector<DownloadCubit, DownloadState, DownloadStatus>(
            selector: (state) {
          return readDownloadCubit(context).getDownloadType(filename);
        }, builder: (context, downloadType) {
          switch (downloadType) {
            case DownloadStatus.redirecting:
              return const Center(child: CircularProgressIndicator());
            case DownloadStatus.downloading:
              return _buildDownloadProgress(filename);
            case DownloadStatus.succeed:
              return LineButton(
                enabled: false,
                text: '已下载',
                onPressed: () {  },
              );
            default:
              return FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: styleManager
                      .colorScheme(context)
                      .secondaryContainer,
                ),
                onPressed: () => onPressed(),
                child: Icon(
                  UniconsLine.file_download,
                  color: styleManager
                      .colorScheme(context)
                      .onSecondaryContainer,
                ),
              );
          }
        }),
      ),
    );
  }

  Widget _buildDownloadProgress(String filename) {
    return BlocSelector<DownloadCubit, DownloadState, double>(
      selector: (state) {
        return state.taskProgress[filename] ?? 0.0;
      },
      builder: (context, state) {
        return Center(
          child: Text(
            '${(state * 100).toStringAsFixed(2)}%',
          ),
        );
      },
    );
  }
}
