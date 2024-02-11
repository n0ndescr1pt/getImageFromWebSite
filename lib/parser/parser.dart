import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/parser/item.dart';

class Parser {
  List<Item> list = [];

  Future<List<Item>> parseImgHTML(String url) async {
    var response = await http.get(Uri.parse(url));
    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      String htmlToParse = response.body;
      RegExp exp = RegExp(r'''"(http(s)?:\S*\.(png|jpg))"'''); //выбираем все ссылки на картинки по шаблону
      Iterable<RegExpMatch> matches = exp.allMatches(htmlToParse);
      print(matches.first);
      if (matches.isEmpty) { //если ничего нет, возвращаем 
        return [Item(resolution: "", url: "No image", size: "")];
      }
      

      for (final m in matches) {
        print(m.group(1)!);
        list.add(await _getImageInfo(m.group(1)!));
      }

      return list;

    } else {
      return [Item(resolution: "", url: "No image", size: "")];
    }
  }

  Future<Item> _getImageInfo(String imageUrl) async { //создаем элемент с данными: ссылка, размер, вес
    try {
      final size = await  _calculateImageDimension(imageUrl);
      //http.Response r = await http.get(Uri.parse(imageUrl));   //я не понимаю каким образом мне получать разрешение изображения быстрее,
      //final fileSize = r.headers["content-length"];           // я пробовал в headers["content-length"], но таким образом все еще дольше
                                                                //если не находить размер изображения, то фото грузятся моментально
      
      final item = Item(
        url: imageUrl,
        size: "${(size.width * size.height / 1024 / 4).roundToDouble()}",
        resolution: "${size.height.round()} x ${size.width.round()}",
      );
      return item;
    } catch (e) {
      print('Error occurred: $e');
      return Item(url: imageUrl, size: "0", resolution: "");
    }
  }

  Future<Size> _calculateImageDimension(String imageUrl) {//метод который возвращает размер изображения (Ширину и Высоту) по его ссылке
    Completer<Size> completer = Completer();
    Image image = Image.network(imageUrl);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }
}
