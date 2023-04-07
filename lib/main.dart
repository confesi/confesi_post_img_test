import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Img Share Test',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Img Share Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Image? img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _screenshot,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _buildImage()),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: .8,
      child: Container(
        color: Colors.redAccent,
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Flexible(
                        child: Text(
                          "University of Victoria • April 6, 2023",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Flexible(
                        child: Text(
                          "Boyfriends, man",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Is it just me, or do all boyfriends keep pretending to be girls moaning? Like, you think I want this? 😂",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    CupertinoIcons.chat_bubble_2_fill,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "16",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Icon(
                                    CupertinoIcons.up_arrow,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "24",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    CupertinoIcons.down_arrow,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Confesi",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "confesi.page.link/d8F1",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// todo: if text is too big, split it up into multiple images so it can be reposted to social media sites with bg music
// todo: add an "export comment" button or share comment button in settings somewhere. Also add to post. Maybe a "share post" and "export post"
  Future<void> _screenshot() async {
    ScreenshotController screenshotController = ScreenshotController();
    // screenshotController.capture(delay: Duration(milliseconds: 10));
    screenshotController
        .captureFromWidget(_buildImage(), delay: const Duration(milliseconds: 10))
        .then((capturedImage) async {
      // Save image to file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/confession.png');
      await file.writeAsBytes(capturedImage);
      // Share image file
      Share.shareXFiles([XFile(file.path)], text: 'https://confesi.page.link/d8F1');
    });
  }
}
//   Future<void> getCanvasImage(String str) async {
//     var builder = ParagraphBuilder(ParagraphStyle(fontStyle: FontStyle.normal));
//     builder.addText(str);
//     Paragraph paragraph = builder.build();
//     paragraph.layout(const ParagraphConstraints(width: 100));

//     final recorder = PictureRecorder();
//     var newCanvas = Canvas(recorder);

//     newCanvas.drawParagraph(paragraph, Offset.zero);

//     final picture = recorder.endRecording();
//     var res = await picture.toImage(500, 500);
//     ByteData? data = await res.toByteData(format: ImageByteFormat.png);

//     if (data != null) {
//       img = Image.memory(Uint8List.view(data.buffer));
//       // Save image to file
//       final directory = await getApplicationDocumentsDirectory();
//       final file = File('${directory.path}/image.png');
//       print(file);
//       await file.writeAsBytes(data.buffer.asUint8List());
//       // Share.shareXFiles([XFile(file.path)], text: 'Great picture');
//       print("HERE");
//     }

//     setState(() {});
//   }

//   void _onPressedButton() {
//     getCanvasImage(controller.text);
//   }
// }
