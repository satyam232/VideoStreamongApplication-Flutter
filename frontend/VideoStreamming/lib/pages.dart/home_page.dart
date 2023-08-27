import 'dart:convert';
import 'package:videostreaming/custom_row.dart';
import 'package:videostreaming/models/category.dart';
import 'package:videostreaming/models/movie_model.dart';
import 'package:videostreaming/pages.dart/video.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'explore',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: 'Profile',
    ),
  ];
  late Future<List<Categories>> _dataFuture;

  Future<List<Categories>> fetchAllCategory() async {
    final response = await http.get(
      Uri.parse(''), //replace with category api
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final dataList = jsonData['data'] as List<dynamic>;

      List<Categories> allData =
          dataList.map((item) => Categories.fromJson(item)).toList();
      return allData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Data>> fetchAllData(String categoryId) async {
    final response = await http.get(
      Uri.parse('' + categoryId), //replace with category api
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final dataList = jsonData['data'] as List<dynamic>;

      List<Data> allData = dataList.map((item) => Data.fromJson(item)).toList();
      return allData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchAllCategory();
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataFuture = fetchAllCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Categories>>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No categories available.'),
              );
            } else {
              List<Categories> categoryData = snapshot.data!;
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu),
                    ),
                    pinned: true,
                    stretch: true,
                    backgroundColor: Theme.of(context).backgroundColor,
                    expandedHeight: 10.0,
                    flexibleSpace: FlexibleSpaceBar(
                      expandedTitleScale: 1,
                      collapseMode: CollapseMode.parallax,
                      title: Text("SR Streaming"),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FutureBuilder<List<Data>>(
                          future: fetchAllData(categoryData[index].id),
                          builder: (context, dataSnapshot) {
                            if (dataSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (dataSnapshot.hasError) {
                              return Center(
                                child: Text('Error: ${dataSnapshot.error}'),
                              );
                            } else if (!dataSnapshot.hasData ||
                                dataSnapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  'No movie data available for this category.',
                                ),
                              );
                            } else {
                              List<Data> dataList = dataSnapshot.data!;
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Column(children: [
                                      Text(
                                        categoryData[index].title,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        categoryData[index].description,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Container(
                                    height: 310,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: dataList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Videos(
                                                  videoS: dataList[index]
                                                      .movieurl!
                                                      .toString(),
                                                  title: dataList[index]
                                                      .title!
                                                      .toString(),
                                                  dsc: dataList[index]
                                                      .description!
                                                      .toString(),
                                                  img: dataList[index]
                                                      .image!
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 280,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    dataList[index]
                                                        .image!
                                                        .toString(),
                                                    height: 200,
                                                    width: double.infinity,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                CustomRowWidget(
                                                  img: dataList[index].image!,
                                                  dsc: dataList[index]
                                                      .description!,
                                                  titl: dataList[index].title!,
                                                ),
                                                Divider(
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                      childCount: categoryData.length,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: items, onTap: (a) {}),
    );
  }
}
