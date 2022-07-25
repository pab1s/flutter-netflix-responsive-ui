import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/cubits/cubits.dart';
import 'package:flutter_netflix_responsive_ui/data/data.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

import '../cubits/cubits.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
    ..addListener(() {
      context.read<AppBarCubit>().setOffset(_scrollController!.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Cast'),
        child: const Icon(Icons.cast),
        backgroundColor: Colors.grey[850],
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(scrollOffset: scrollOffset);
          }
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: const PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: const PageStorageKey('myList'),
              title: 'My List',
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: const PageStorageKey('originals'),
              title: 'Netflix Originals',
              contentList: originals,
              isOriginals: true,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: const PageStorageKey('trending'),
              title: 'Trending',
              contentList: trending,
            ),
          ),
        ],
      ),
    );
  }
}
