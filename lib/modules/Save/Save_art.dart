import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menafn/layout/news_app/cubit/cubit.dart';
import 'package:menafn/layout/news_app/cubit/states.dart';
import 'package:menafn/modules/artical_view/article_view.dart';
import 'package:menafn/shared/const.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
// this class design save page and function to do that
class SaveArt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          if (MediaQuery.of(context).size.width < 600) {
            return SmartRefresher(
              controller: cubit.refreshController,
              enablePullUp: false,
              enablePullDown: true,
              onRefresh: cubit.RefreshSave,
              header: CustomHeader(
                  builder: (BuildContext context, RefreshStatus? mode) {
                Widget body;
                if (mode == RefreshStatus.idle) {
                  body = Text("pull Down Refresh");
                } else if (mode == RefreshStatus.refreshing) {
                  body = CupertinoActivityIndicator();
                } else if (mode == RefreshStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == RefreshStatus.canRefresh) {
                  body = Text("release to Refresh more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              }),
              child: ListView.builder(
                itemCount: saved.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(top: 0.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoryView(
                                              storyId: saved[index]['newsId'],
                                            )
                                    ));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 220,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                    saved[index]['imagePath'],
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
                                      saved[index]['newsTitle'],
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: const Icon(Icons.delete_sharp),
                                      color: Colors.grey,
                                      onPressed: () {
                                        cubit.deleteartFromDatabase(
                                          saved[index]['newsId'],
                                        );
                                      }),
                                  IconButton(
                                    icon: const Icon(Icons.share),
                                    color: Colors.grey,
                                    onPressed: () {
                                      Share.share(
                                          'check out this news ' +
                                              saved[index]['link'],
                                          subject: saved[index]['title']);
                                    },
                                  ),
                                ]),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return SmartRefresher(
                controller: cubit.refreshController,
                enablePullUp: false,
                enablePullDown: true,
                onRefresh: cubit.RefreshSave,
                header: CustomHeader(
                    builder: (BuildContext context, RefreshStatus? mode) {
                  Widget body;
                  if (mode == RefreshStatus.idle) {
                    body = Text("pull Down Refresh");
                  } else if (mode == RefreshStatus.refreshing) {
                    body = CupertinoActivityIndicator();
                  } else if (mode == RefreshStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else if (mode == RefreshStatus.canRefresh) {
                    body = Text("release to Refresh more");
                  } else {
                    body = Text("No more Data");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child: body),
                  );
                }),
                child: SingleChildScrollView(
                  child: GridView.count(
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 3.0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(
                      saved.length,
                      (index) {
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
                                                storyId: saved[index]['newsId'],
                                              )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      saved[index]['imagePath'],
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
                                        saved[index]['newsTitle'],
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          icon: const Icon(
                                            Icons.delete_sharp,
                                            size: 30,
                                          ),
                                          color: Colors.grey,
                                          onPressed: () {
                                            cubit.deleteartFromDatabase(
                                              saved[index]['newsId'],
                                            );
                                          }),
                                      IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          size: 40,
                                        ),
                                        color: Colors.grey,
                                        onPressed: () {
                                          Share.share(
                                            'check out this news ' +
                                                saved[index]['link'],
                                            subject: saved[index]['newsTitle'],
                                          );
                                        },
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ));
          }
        });
  }
}
