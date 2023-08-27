import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/movie_model.dart';
import 'pages.dart/video.dart';

class RefreshIndicato extends StatefulWidget {
  const RefreshIndicato({Key? key}) : super(key: key);

  @override
  State<RefreshIndicato> createState() => _RefreshIndicatorState();
}

class _RefreshIndicatorState extends State<RefreshIndicato> {
  late Future<List<Data>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchAllData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _dataFuture = fetchAllData();
    });
  }

  Future<List<Data>> fetchAllData() async {
    final response = await http.get(
      Uri.parse(
          'http://172.18.165.196:5000/user/movies'), // Replace with your API endpoint
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
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<List<Data>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No movie data available.'),
            );
          } else {
            List<Data> dataList = snapshot.data!;
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Videos(
                          videoS: dataList[index].movieurl!.toString(),
                          title: dataList[index].title!.toString(),
                          dsc: dataList[index].description!.toString(),
                          img: dataList[index].image!.toString(),
                        ),
                      ),
                    );
                  },
                  leading:
                      Image(image: NetworkImage(dataList[index].image ?? '')),
                  title: Text(dataList[index].title ?? ''),
                  subtitle: Text(dataList[index].description ?? ''),
                );
              },
            );
          }
        },
      ),
    );
  }
}
