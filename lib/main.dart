import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dear_feature/dear_feature_usertext.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final myController = TextEditingController();

  String refreshText = '';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text('Exercise 6.2'),
          ),
        ),
        body: BlocProvider(
          create: (BuildContext context) => userText(),
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Enter Text in the form below',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  BlocBuilder<userText, String>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: myController,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          onEditingComplete: () {
                            context
                                .read<userText>()
                                .textInput(myController.text.toString());

                            FocusScope.of(context).unfocus();
                          },
                        ),
                      );
                    },
                  ),
                  BlocBuilder<userText, String>(builder: (context, text) {
                    return FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('$text'.toUpperCase()),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 15),
                                  ),
                                  child: Text('CLOSE'),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                    context
                                        .read<userText>()
                                        .textInput(refreshText);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.text_fields),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
