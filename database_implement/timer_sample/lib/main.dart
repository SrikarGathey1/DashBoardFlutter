import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController controller;

  double progress = 0.0;
  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '${count.inSeconds}';
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 60));
    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Boss"),
        ),
        body: Container(
          padding: EdgeInsets.all(32.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                ),
              ),
              AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                        countText,
                        style: TextStyle(fontSize: 60),
                      )),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(50.0),
                          child: GestureDetector(
                              onTap: () {
                                if (controller.isAnimating) {
                                  controller.stop();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                } else {
                                  controller.reverse(
                                      from: controller.value == 0
                                          ? 1.0
                                          : controller.value);
                                  setState(() {
                                    isPlaying = true;
                                  });
                                }
                              },
                              child: ElevatedButton(
                                onPressed: null,
                                child: isPlaying == true
                                    ? Icon(Icons.pause)
                                    : Icon(Icons.play_arrow),
                              ))),
                      Padding(
                          padding: EdgeInsets.all(50.0),
                          child: GestureDetector(
                              onTap: (() {
                                controller.reset();
                                setState(() {
                                  isPlaying = false;
                                });
                              }),
                              child: ElevatedButton(
                                  onPressed: (() {}), child: Icon(Icons.stop))))
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
