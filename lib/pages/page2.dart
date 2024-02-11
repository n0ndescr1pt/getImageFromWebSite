import 'package:flutter/material.dart';
import 'package:test_app/component/element.dart';
import 'package:test_app/parser/item.dart';
import 'package:test_app/parser/parser.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late String url;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    url = settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: _getColumnImg(url),
    );
  }

  Widget _getColumnImg(String url) {
    final parser = Parser();
    return FutureBuilder<List<Item>?>(
      future: parser.parseImgHTML(url),
      builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading...");
        }
        if (snapshot.hasData && snapshot.data![0].url == "No image") {
          return const Text("No image on this site");
        }
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MyElement(snapshot: snapshot, index: index);
            },
          );
        }

        /// handles others as you did on question
        else {
          return const Text("No image on this site");
        }
      },
    );
  }
}
