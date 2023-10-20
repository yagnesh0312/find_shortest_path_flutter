import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int row = 32;
  int col = 50;
  final infinity = 99999;
  final start = "start";
  final end = "end";
  final barrier = "barrier";
  final open = "open";
  final closed = "closed";
  final unused = "unused";
  var currentButton = "";
  var value;
  bool st = false;
  bool e = false;
  var color;
  var parentNode;
  var status;
  late List<List<int>> opens;
  Color border = Colors.yellowAccent;
  Color fill = Colors.yellow;
  
  List<List<int>>? close;
  List<int>? endPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = List<List>.generate(row,
        (i) => List<int>.generate(col, (index) => infinity, growable: false),
        growable: false);
    color = List<List>.generate(
        row,
        (i) => List<Color>.generate(
            col, (index) => Colors.grey.withOpacity(0.3),
            growable: false),
        growable: false);
    parentNode = List<List>.generate(
        row, (i) => List<String>.generate(col, (index) => "", growable: false),
        growable: false);
    status = List<List>.generate(row,
        (i) => List<String>.generate(col, (index) => unused, growable: false),
        growable: false);
    opens = [];
  }

  void play() async {
    if (endPosition == null) {
      return;
    }
    int r, c;
    late List<List<int>> tmpopens = [];
    bool arrived = false;
    while (!arrived) {
      tmpopens = [];
      for (var i = 0; i < opens.length; i++) {
        r = opens[i][0];
        c = opens[i][1];
        print("$r = ${endPosition![0]} and $c = ${endPosition![1]}");

        //upper main [r - 1][c]
        if (status[r - 1][c] == unused && r - 1 - 1 != -1) {
          int min = infinity;
          // upper [r - 1 - 1][c]
          if (status[r - 1 - 1][c] != unused &&
              value[r - 1][c] + value[r - 1 - 1][c] < min) {
            parentNode[r - 1 - 1][c] = "$r $c";
            min = value[r - 1][c] + value[r - 1 - 1][c];
          }
          // left [r][c - 1]
          if (status[r][c - 1] != unused &&
              value[r - 1][c] + value[r][c - 1] < min) {
            parentNode[r][c - 1] = "$r $c";
            min = value[r - 1][c] + value[r][c - 1];
          }
          // right [r - 1][c + 1]
          if (status[r - 1][c + 1] != unused &&
              value[r - 1][c] + value[r - 1][c + 1] < min) {
            parentNode[r - 1][c] = "$r $c";
            min = value[r - 1][c] + value[r - 1][c + 1];
          }
          if (r - 1 != -1) {
            tmpopens.add([r - 1, c]);
          }
          value[r - 1][c] = min;
          status[r - 1][c] = open;
          color[r - 1][c] = border;
          if (endPosition![0] == r - 1 && endPosition![1] == c) {
            arrived = true;
          }
        }
        // bottom main [r + 1][c]
        if (status[r + 1][c] == unused && r + 2 != row) {
          int min = infinity;
          // left [r + 1][c - 1]
          if (status[r + 1][c - 1] != unused &&
              value[r + 1][c] + value[r + 1][c - 1] < min) {
            min = value[r + 1][c] + value[r + 1][c - 1];
            parentNode[r + 1][c - 1] = "$r $c";
          }
          // right [r + 1][c + 1]
          if (status[r + 1][c + 1] != unused &&
              value[r + 1][c] + value[r + 1][c + 1] < min) {
            min = value[r + 1][c] + value[r + 1][c + 1];
            parentNode[r + 1][c + 1] = "$r $c";
          }
          // bottom [r + 1 + 1][c]
          if (status[r + 1 + 1][c] != unused &&
              value[r + 1][c] + value[r + 1 + 1][c] < min) {
            min = value[r + 1][c] + value[r + 1 + 1][c];
            parentNode[r + 1 + 1][c] = "$r $c";
          }
          value[r + 1][c] = min;
          status[r + 1][c] = open;
          color[r + 1][c] = border;
          if (endPosition![0] == r + 1 && endPosition![1] == c) {
            arrived = true;
          }
          if (r + 1 != row) {
            tmpopens.add([r + 1, c]);
          }
        }
        // Right main [r][c + 1]
        if (status[r][c + 1] == unused && c + 2 != col) {
          int min = infinity;
          // right [r][c + 1 + 1]
          if (status[r][c + 1 + 1] != unused &&
              value[r][c + 1] + value[r][c + 1 + 1] < min) {
            min = value[r][c + 1] + value[r][c + 1 + 1];
            parentNode[r][c + 1 + 1] = "$r $c";
          }
          // upper [r - 1][c + 1]
          if (status[r - 1][c + 1] != unused &&
              value[r][c + 1] + value[r - 1][c + 1] < min) {
            min = value[r][c + 1] + value[r - 1][c + 1];
            parentNode[r - 1][c + 1] = "$r $c";
          }
          // bottom [r + 1][c + 1]
          if (status[r + 1][c + 1] != unused &&
              value[r][c + 1] + value[r + 1][c + 1] < min) {
            min = value[r][c + 1] + value[r + 1][c + 1];
            parentNode[r + 1][c + 1] = "$r $c";
          }
          value[r][c + 1] = min;
          status[r][c + 1] = open;
          color[r][c + 1] = border;
          if (endPosition![0] == r && endPosition![1] == c + 1) {
            arrived = true;
          }
          if (c + 1 != col) {
            tmpopens.add([r, c + 1]);
          }
        }
        // left main [r][c - 1]
        if (status[r][c - 1] == unused && c - 1 - 1 != 0) {
          int min = infinity;
          // left [r][c - 1 - 1]
          if (status[r][c - 1 - 1] != unused &&
              value[r][c - 1] + value[r][c - 1 - 1] < min) {
            min = value[r][c - 1] + value[r][c - 1 - 1];
            parentNode[r][c - 1 - 1] = "$r $c";
          }
          // upper [r - 1][c - 1]
          if (status[r - 1][c - 1] != unused &&
              value[r][c - 1] + value[r - 1][c - 1] < min) {
            min = value[r][c - 1] + value[r - 1][c - 1];
            parentNode[r - 1][c - 1] = "$r $c";
          }
          // bottom [r + 1][c - 1]
          if (status[r + 1][c - 1] != unused &&
              value[r][c - 1] + value[r + 1][c - 1] < min) {
            min = value[r][c - 1] + value[r + 1][c - 1];
            parentNode[r + 1][c - 1] = "$r $c";
          }
          value[r][c - 1] = min;
          status[r][c - 1] = open;
          color[r][c - 1] = border;
          if (endPosition![0] == r && endPosition![1] == c - 1) {
            arrived = true;
          }
          if (c - 1 != -1) {
            tmpopens.add([r, c - 1]);
          }
        }
        color[r][c] = fill;
        print(arrived);
        await Future.delayed(Duration(microseconds: 100));
        setState(() {});
      }

      opens = tmpopens;
    }

    // print(opens);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Start",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  currentButton = "start";
                }),
            CupertinoButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "End",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  currentButton = "end";
                }),
            CupertinoButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Barrier",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  currentButton = "barrier";
                }),
            CupertinoButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Play",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onPressed: () {
                  play();
                }),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < row; i++) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int j = 0; j < col; j++) ...[
                        GestureDetector(
                          onTap: () {
                            if (currentButton == start && !st) {
                              color[i][j] = Colors.green;
                              opens.add([i, j]);
                              value[i][j] = 0;
                              st = true;
                            }
                            if (currentButton == end && !e) {
                              color[i][j] = Colors.red;
                              endPosition = [i, j];
                              print(endPosition);
                              e = true;
                            }
                            if (currentButton == barrier) {
                              color[i][j] = Colors.blue;
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: color[i][j],
                                border: Border.all(
                                    color: Colors.black12, width: 1)),
                            child: Text(value[i][j].toString()),
                          ),
                        ),
                      ]
                    ],
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
