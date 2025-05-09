import 'package:auto_novel_reader_flutter/bloc/global/global_bloc.dart';
import 'package:auto_novel_reader_flutter/manager/style_manager.dart';
import 'package:auto_novel_reader_flutter/ui/view/reader/favored.dart';
import 'package:auto_novel_reader_flutter/ui/view/reader/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderView extends StatefulWidget {
  const ReaderView({super.key});

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  var isModalVisible = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: styleManager.colorScheme(context).shadow,
          backgroundColor: styleManager.colorScheme(context).secondaryContainer,
          title: _buildTabBar(),
        ),
        body: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (context, state) {
            return const TabBarView(
              children: [
                FavoredView(),
                HistoryView(),
              ],
            );
          },
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return const TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      tabs: [
        Tab(text: '收藏'),
        Tab(text: '历史'),
      ],
    );
  }
}
