import 'package:flutter/material.dart';
import 'package:test_app/component/my_button.dart';
import 'package:test_app/component/my_text_field.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final textEditingController = TextEditingController();

  void onTap() {
    String string = textEditingController.text;
    RegExp exp = RegExp(
        r'''(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:\/~+#-]*[\w@?^=%&\/~+#-])''');
    if (textEditingController.text.isNotEmpty && exp.hasMatch(string)) {
      Navigator.pushNamed(context, '/page2',
          arguments: textEditingController.text);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('uncorrect url'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text("Test application"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              MyTextField(textEditingController: textEditingController), 

              const SizedBox(height: 12),
              
              MyButton(onTap: onTap) 
            ],
          ),
        ),
      ),
    );
  }
}
