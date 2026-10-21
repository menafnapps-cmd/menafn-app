import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/modules/artical_view/article_view.dart';
import 'package:menafn/shared/const.dart';
import 'package:menafn/shared/native_inline_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

class EntertainmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..initDb()
        ..getEntertainment(),
      child: BlocConsumer<NewsCubit, NewsStates>(listener: (context, state) {
        if (state is loadentertainmentState) {
          print('loadentertainmentState');
        }
      }, builder: (context, state) {
        var cubit = NewsCubit.get(context);
        if (MediaQuery.of(context).size.width < 600) {
          return SmartRefresher(
            controller: cubit.refreshController,
            onLoading: cubit.getEntertainment,
            enablePullDown: false,
            enablePullUp: true,
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: ListView.builder(
              itemCount: cubit.Entertainment.length,
              itemBuilder: (context, index) {
                Color color = Colors.black12;
                for (int i = 0; i < saved.length; i++) {
                  if (cubit.Entertainment[index].newsid == saved[i]['newsId']) {
                    color = Color(0xff88db52);
                  }
                }
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoryView(
                                        storyId:
                                            cubit.Entertainment[index].newsid,
                                      )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                              cubit.Entertainment[index].picture,
                            ),
                            fit: BoxFit.contain,
                          )),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.transparent.withOpacity(0),
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(1)
                                  ])),
                              child: Text(
                                cubit.Entertainment[index].title,
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        IconButton(
                          icon: color == Colors.black12
                              ? Icon(
                                  Icons.bookmark_border_sharp,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.bookmark_sharp,
                                  color: Color(0xff88db52),
                                ),
                          onPressed: () {
                            cubit.insertArt(
                                id: cubit.Entertainment[index].newsid,
                                imagePath: cubit.Entertainment[index].picture,
                                newsTitle: cubit.Entertainment[index].title,
                                link: cubit.Entertainment[index].link);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          color: Colors.grey,
                          onPressed: () {
                            Share.share(
                                'check out this news ' +
                                    cubit.Entertainment[index].link,
                                subject: cubit.Entertainment[index].title);
                          },
                        ),
                      ]),
                      SizedBox(
                        height: 5,
                      ),
                      if ((index + 2) % 5 == 0)
                        Container(
                          height: 250,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: NativeInlinePage(250),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (MediaQuery.of(context).size.width >= 600 &&
            MediaQuery.of(context).size.width < 750) {
          return SmartRefresher(
              controller: cubit.refreshController,
              onLoading: cubit.getEntertainment,
              enablePullDown: false,
              enablePullUp: true,
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: SingleChildScrollView(
                child: GridView.count(
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 3.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                    cubit.Entertainment.length,
                    (index) {
                      Color color = Colors.black12;
                      for (int i = 0; i < saved.length; i++) {
                        if (cubit.Entertainment[index].newsid ==
                            saved[i]['newsId']) {
                          color = const Color(0xff88db52);
                        }
                      }
                      if ((index + 2) % 5 != 0) {
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoryView(
                                                storyId: cubit
                                                    .Entertainment[index]
                                                    .newsid,
                                              )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      cubit.Entertainment[index].picture,
                                    ),
                                    fit: BoxFit.contain,
                                  )),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.transparent.withOpacity(0),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(1)
                                          ])),
                                      child: Text(
                                        cubit.Entertainment[index].title,
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: color == Colors.black12
                                          ? Icon(
                                              Icons.bookmark_border_sharp,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.bookmark_sharp,
                                              color: Color(0xff88db52),
                                            ),
                                      onPressed: () {
                                        cubit.insertArt(
                                            id: cubit
                                                .Entertainment[index].newsid,
                                            imagePath: cubit
                                                .Entertainment[index].picture,
                                            newsTitle: cubit
                                                .Entertainment[index].title,
                                            link: cubit
                                                .Entertainment[index].link);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.share),
                                      color: Colors.grey,
                                      onPressed: () {
                                        Share.share(
                                            'check out this news ' +
                                                cubit.Entertainment[index].link,
                                            subject: cubit
                                                .Entertainment[index].title);
                                      },
                                    ),
                                  ]),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: 300,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: NativeInlinePage(300),
                        );
                      }
                    },
                  ),
                ),
              ));
        } else if (MediaQuery.of(context).size.width >= 750 &&
            MediaQuery.of(context).size.width < 900) {
          return SmartRefresher(
              controller: cubit.refreshController,
              onLoading: cubit.getEntertainment,
              enablePullDown: false,
              enablePullUp: true,
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: SingleChildScrollView(
                child: GridView.count(
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 3.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                    cubit.Entertainment.length,
                    (index) {
                      Color color = Colors.black12;
                      for (int i = 0; i < saved.length; i++) {
                        if (cubit.Entertainment[index].newsid ==
                            saved[i]['newsId']) {
                          color = const Color(0xff88db52);
                        }
                      }
                      if ((index + 2) % 5 != 0) {
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoryView(
                                                storyId: cubit
                                                    .Entertainment[index]
                                                    .newsid,
                                              )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      cubit.Entertainment[index].picture,
                                    ),
                                    fit: BoxFit.contain,
                                  )),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.transparent.withOpacity(0),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(1)
                                          ])),
                                      child: Text(
                                        cubit.Entertainment[index].title,
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: color == Colors.black12
                                          ? Icon(
                                              Icons.bookmark_border_sharp,
                                              color: Colors.grey,
                                              size: 40,
                                            )
                                          : Icon(
                                              Icons.bookmark_sharp,
                                              color: Color(0xff88db52),
                                              size: 40,
                                            ),
                                      onPressed: () {
                                        cubit.insertArt(
                                            id: cubit
                                                .Entertainment[index].newsid,
                                            imagePath: cubit
                                                .Entertainment[index].picture,
                                            newsTitle: cubit
                                                .Entertainment[index].title,
                                            link: cubit
                                                .Entertainment[index].link);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        size: 40,
                                      ),
                                      color: Colors.grey,
                                      onPressed: () {
                                        Share.share(
                                            'check out this news ' +
                                                cubit.Entertainment[index].link,
                                            subject: cubit
                                                .Entertainment[index].title);
                                      },
                                    ),
                                  ]),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: 300,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: NativeInlinePage(300),
                        );
                      }
                    },
                  ),
                ),
              ));
        } else if (MediaQuery.of(context).size.width >= 900 &&
            MediaQuery.of(context).size.width < 1000) {
          return SmartRefresher(
              controller: cubit.refreshController,
              onLoading: cubit.getEntertainment,
              enablePullDown: false,
              enablePullUp: true,
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: SingleChildScrollView(
                child: GridView.count(
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 3.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(
                    cubit.Entertainment.length,
                    (index) {
                      Color color = Colors.black12;
                      for (int i = 0; i < saved.length; i++) {
                        if (cubit.Entertainment[index].newsid ==
                            saved[i]['newsId']) {
                          color = const Color(0xff88db52);
                        }
                      }
                      if ((index + 2) % 5 != 0) {
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoryView(
                                                storyId: cubit
                                                    .Entertainment[index]
                                                    .newsid,
                                              )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      cubit.Entertainment[index].picture,
                                    ),
                                    fit: BoxFit.contain,
                                  )),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.transparent.withOpacity(0),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(1)
                                          ])),
                                      child: Text(
                                        cubit.Entertainment[index].title,
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: color == Colors.black12
                                            ? Icon(
                                                Icons.bookmark_border_sharp,
                                                color: Colors.grey,
                                                size: 35,
                                              )
                                            : Icon(
                                                Icons.bookmark_sharp,
                                                color: Color(0xff88db52),
                                                size: 35,
                                              ),
                                        onPressed: () {
                                          cubit.insertArt(
                                              id: cubit
                                                  .Entertainment[index].newsid,
                                              imagePath: cubit
                                                  .Entertainment[index].picture,
                                              newsTitle: cubit
                                                  .Entertainment[index].title,
                                              link: cubit
                                                  .Entertainment[index].link);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          size: 35,
                                        ),
                                        color: Colors.grey,
                                        onPressed: () {
                                          Share.share(
                                              'check out this news ' +
                                                  cubit.Entertainment[index]
                                                      .link,
                                              subject: cubit
                                                  .Entertainment[index].title);
                                        },
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: 300,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: NativeInlinePage(300),
                        );
                      }
                    },
                  ),
                ),
              ));
        } else if (MediaQuery.of(context).size.width >= 1000 &&
            MediaQuery.of(context).size.width <= 1400) {
          return SmartRefresher(
              controller: cubit.refreshController,
              onLoading: cubit.getEntertainment,
              enablePullDown: false,
              enablePullUp: true,
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text("pull up load");
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("release to load more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                },
              ),
              child: SingleChildScrollView(
                child: GridView.count(
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 3.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(
                    cubit.Entertainment.length,
                    (index) {
                      Color color = Colors.black12;
                      for (int i = 0; i < saved.length; i++) {
                        if (cubit.Entertainment[index].newsid ==
                            saved[i]['newsId']) {
                          color = const Color(0xff88db52);
                        }
                      }
                      if ((index + 2) % 5 != 0) {
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoryView(
                                                storyId: cubit
                                                    .Entertainment[index]
                                                    .newsid,
                                              )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 350,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      cubit.Entertainment[index].picture,
                                    ),
                                    fit: BoxFit.contain,
                                  )),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.transparent.withOpacity(0),
                                            Colors.black.withOpacity(0.5),
                                            Colors.black.withOpacity(1)
                                          ])),
                                      child: Text(
                                        cubit.Entertainment[index].title,
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: color == Colors.black12
                                            ? Icon(
                                                Icons.bookmark_border_sharp,
                                                color: Colors.grey,
                                                size: 40,
                                              )
                                            : Icon(
                                                Icons.bookmark_sharp,
                                                color: Color(0xff88db52),
                                                size: 40,
                                              ),
                                        onPressed: () {
                                          cubit.insertArt(
                                              id: cubit
                                                  .Entertainment[index].newsid,
                                              imagePath: cubit
                                                  .Entertainment[index].picture,
                                              newsTitle: cubit
                                                  .Entertainment[index].title,
                                              link: cubit
                                                  .Entertainment[index].link);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          size: 40,
                                        ),
                                        color: Colors.grey,
                                        onPressed: () {
                                          Share.share(
                                              'check out this news ' +
                                                  cubit.Entertainment[index]
                                                      .link,
                                              subject: cubit
                                                  .Entertainment[index].title);
                                        },
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: 300,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: NativeInlinePage(300),
                        );
                      }
                    },
                  ),
                ),
              ));
        }
        return Container();
      }),
    );
  }
}
