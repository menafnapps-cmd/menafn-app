import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/shared/adsManager.dart';
import 'package:menafn/shared/const.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// =====================================
/// Class to show story news
class StoryView extends StatelessWidget {
  final int storyId;

  StoryView({
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getNews(storyId)
        ..initDb(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, states) {
          var cubit = NewsCubit.get(context);

          Color color = Colors.white;

          for (int i = 0; i < saved.length; i++) {
            if (storyId == saved[i]['newsId']) {
              color = Colors.indigo;
            }
          }

          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: color == Colors.white
                      ? const Icon(
                    Icons.bookmark_border_sharp,
                  )
                      : const Icon(
                    Icons.bookmark_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await cubit.insertArt(
                      id: cubit.oneStory[0].newsID,
                      imagePath: cubit.oneStory[0].imagePath,
                      newsTitle: cubit.oneStory[0].newsTitle,
                      link: cubit.oneStory[0].newsLink,
                    );
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    final String newsLink =
                        cubit.oneStory[0].newsLink ?? "";

                    await Share.share(
                      'check out this news $newsLink',
                      subject: cubit.oneStory[0].newsTitle,
                    );
                  },
                  child: const Icon(Icons.share),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              backgroundColor: const Color(0xff88db52),
              elevation: 0.0,
            ),

            body: PageView.builder(
              itemCount: cubit.oneStory.length,
              itemBuilder: (
                  BuildContext context,
                  int index,
                  ) {
                return CardItem(
                  content: cubit.oneStory[index].newsBody ?? "",
                  head: cubit.oneStory[index].newsDate ?? "",
                  picUrl: cubit.oneStory[index].imagePath ?? "",
                  title: cubit.oneStory[index].newsTitle ?? "",

                  // newsID is int
                  newsid: cubit.oneStory[index].newsID,

                  nLink: cubit.oneStory[index].newsLink ?? "",
                  disc: cubit.oneStory[index].newsDisclaimer ?? "",
                  logo: cubit.oneStory[index].providerLogo ?? "",
                );
              },
            ),
          );
        },
        listener: (context, states) {},
      ),
    );
  }
}

/// =====================================
/// Card Item
class CardItem extends StatelessWidget {
  final String picUrl;
  final String head;
  final String content;
  final String title;
  final String nLink;
  final String disc;
  final String logo;

  final String? imgUrl;

  final int newsid;

  CardItem({
    required this.picUrl,
    required this.head,
    required this.content,
    required this.title,
    required this.newsid,
    this.imgUrl,
    required this.nLink,
    required this.disc,
    required this.logo,
  });

  /// =====================================
  /// Open URL
  Future<void> _openUrl(String? url) async {
    if (url == null || url.isEmpty) {
      return;
    }

    final Uri? uri = Uri.tryParse(url);

    if (uri == null) {
      return;
    }

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      debugPrint('Could not launch URL: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 300.0,
                color: Colors.white,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const SizedBox(
                          height: 0,
                        ),

                        // ================= IMAGE =================
                        Center(
                          child: ClipRRect(
                            child: Image.network(
                              picUrl,
                              height: 260,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                              errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                  ) {
                                return const SizedBox(
                                  height: 260,
                                  child: Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // ================= TITLE =================
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 0,
                        ),

                        // ================= DATE =================
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 0,
                          ),
                          child: Text(
                            head,
                          ),
                        ),

                        // ================= CONTENT =================
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 30,
                            right: 20,
                          ),
                          child: Html(
                            data: content,

                            // FIXED
                           // onLinkTap: _onLinkTap,

                            style: {
                              "body": Style.fromTextStyle(
                                const TextStyle(
                                  fontSize: 20,
                                  wordSpacing: 3,
                                  height: 1.3,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromRGBO(
                                    38,
                                    38,
                                    38,
                                    0.749019607843373,
                                  ),
                                ),
                              ),
                            },
                          ),
                        ),

                        // ================= LOGO =================
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Image.network(
                                logo,
                                alignment: Alignment.centerLeft,
                                errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                    ) {
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ),
                        ),

                        // ================= ADS =================
                        Container(
                          height: 55,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          child: google_ads(),
                        ),

                        // ================= DISCLAIMER =================
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 30,
                            right: 20,
                          ),
                          child: Html(
                            data: disc,
                            style: {
                              "body": Style.fromTextStyle(
                                const TextStyle(
                                  fontSize: 20,
                                  wordSpacing: 3,
                                  height: 1.3,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat',
                                  color: Color.fromRGBO(
                                    38,
                                    38,
                                    38,
                                    0.749019607843373,
                                  ),
                                ),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ================= BOTTOM ADS =================
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: google_ads(),
            ),
          ],
        ),
      );
    }

    // =========================================================
    // DESKTOP / TABLET
    // =========================================================

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 400.0,
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const SizedBox(
                        height: 0,
                      ),

                      // ================= IMAGE =================
                      Center(
                        child: ClipRRect(
                          child: Image.network(
                            picUrl,
                            height: 400,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                            errorBuilder: (
                                context,
                                error,
                                stackTrace,
                                ) {
                              return const SizedBox(
                                height: 400,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // ================= TITLE =================
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Html(
                          data: title,
                          style: {
                            "body": Style.fromTextStyle(
                              const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 0,
                      ),

                      // ================= DATE =================
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 0,
                          ),
                          child: Html(
                            data: head,
                          ),
                        ),
                      ),

                      // ================= CONTENT =================
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 30,
                          right: 20,
                        ),
                        child: Html(
                          data: content,

                          // FIXED
                         // onLinkTap: _onLinkTap,

                          style: {
                            "body": Style.fromTextStyle(
                              const TextStyle(
                                fontSize: 20,
                                wordSpacing: 3,
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(
                                  38,
                                  38,
                                  38,
                                  0.749019607843373,
                                ),
                              ),
                            ),
                          },
                        ),
                      ),

                      // ================= LOGO =================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Image.network(
                              logo,
                              alignment: Alignment.centerLeft,
                              errorBuilder: (
                                  context,
                                  error,
                                  stackTrace,
                                  ) {
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                      ),

                      // ================= ADS =================
                      Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        child: google_ads(),
                      ),

                      // ================= DISCLAIMER =================
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 30,
                          right: 20,
                        ),
                        child: Html(
                          data: disc,
                          style: {
                            "body": Style.fromTextStyle(
                              const TextStyle(
                                fontSize: 20,
                                wordSpacing: 3,
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(
                                  38,
                                  38,
                                  38,
                                  0.749019607843373,
                                ),
                              ),
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ================= BOTTOM ADS =================
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: google_ads(),
          ),
        ],
      ),
    );
  }
}