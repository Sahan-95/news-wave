import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:news_wave/presentation/utils/extensions/color_extension.dart';

import '../../bloc/news/bloc/news_bloc.dart';
import '../../managers/local_storage_manager.dart';
import '../../utils/colors/color_coding.dart';
import '../../utils/helpers/url_launcher_utils.dart';
import '../../utils/responsive/screen_sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _firstName;

  @override
  void initState() {
    super.initState();
    _loadFirstName();
  }

  Future<void> _loadFirstName() async {
    final firstName =
        await GetIt.instance<SharedPreferencesService>().getFirstName();
    setState(() {
      _firstName = firstName;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = displayHeight(context);
    double screenWidth = displayWidth(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            color: appBarColor.toColor(),
            height: screenHeight,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.075, left: screenWidth * 0.05),
              child: Text(
                'Hey${_firstName != null ? ' $_firstName' : ''}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: screenHeight * 0.04),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.23,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: contentBodyColor.toColor(),
              height: screenHeight,
            ),
          ),
          Positioned(
            top: screenHeight * 0.18,
            bottom: 0,
            left: 0,
            right: 0,
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: state.newsList.length,
                    itemBuilder: (context, index) {
                      final news = state.newsList[index];

                      // Format the date-time to display only relevant date
                      final date = DateTime.fromMillisecondsSinceEpoch(
                          news.datetime * 1000);
                      final formattedDate =
                          DateFormat('d MMMM yyyy').format(date);

                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: news.image,
                          height: screenHeight * 0.15,
                          width: screenWidth * 0.2,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              news.source.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: screenHeight * 0.015),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: screenHeight * 0.015),
                            )
                          ],
                        ),
                        subtitle: Text(
                          news.headline,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: screenHeight * 0.02),
                        ),
                        onTap: () => GetIt.instance<UrlLauncherUtils>()
                            .launchURL(news.url),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  );
                } else if (state is NewsError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
