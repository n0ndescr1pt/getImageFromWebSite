import 'package:flutter/material.dart';
import 'package:test_app/parser/item.dart';

class MyElement extends StatelessWidget {
  final AsyncSnapshot<List<Item>?> snapshot;
  final int index;
  const MyElement({super.key, required this.snapshot, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Image.network(
              snapshot.data![index].url,
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Text(
                    snapshot.data![index].url,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Text("Resolution: ${snapshot.data![index].resolution}"),
                  const SizedBox(height: 10),
                  Text("Size: ${snapshot.data![index].size} kb"),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
