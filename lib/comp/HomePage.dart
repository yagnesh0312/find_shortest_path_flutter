import 'package:find_shortest_path/comp/Node.dart';
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
  final increase = 1;
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

  late List<List<int>> barrierList;
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
    barrierList = [];
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
      // print("not Arrived");
      for (var i = 0; i < opens.length; i++) {
        r = opens[i][0];
        c = opens[i][1];
        print("$r = ${endPosition![0]} and $c = ${endPosition![1]}");
        if (r == endPosition![0] && c == endPosition![1]) {
          arrived = true;
          break;
        }
        int min = infinity;
        // edited here
        // set open Value
        // upper main [r - 1][c]
        print(status[r - 1][c]);
        if (status[r - 1][c] != unused && value[r - 1][c] + increase < min) {
          print("upper");
          min = value[r - 1][c] + increase;
        }
        // bottom main [r + 1][c]
        else if (status[r + 1][c] != unused &&
            value[r + 1][c] + increase < min) {
          print("bottom");
          min = value[r + 1][c] + increase;
        }
        // Right main [r][c + 1]
        else if (status[r][c + 1] != unused &&
            value[r][c + 1] + increase < min) {
          min = value[r][c + 1] + increase;
        }
        // left main [r][c - 1]
        else if (status[r][c - 1] != unused &&
            value[r][c - 1] + increase < min) {
          min = value[r][c - 1] + increase;
        }
        // if start node
        else if (status[r][c + 1] == unused &&
            status[r][c - 1] == unused &&
            status[r + 1][c] == unused &&
            status[r - 1][c] == unused) {
          min = 0;
          tmpopens.add([r - 1, c]);
          status[r - 1][c] = open;
          color[r - 1][c] = Node.border;

          tmpopens.add([r + 1, c]);
          status[r + 1][c] = open;
          color[r + 1][c] = Node.border;

          tmpopens.add([r, c + 1]);
          status[r][c + 1] = open;
          color[r][c + 1] = Node.border;

          tmpopens.add([r, c - 1]);
          status[r][c - 1] = open;
          color[r][c - 1] = Node.border;
          parentNode[r - 1][c] = "$r,$c";
          parentNode[r][c - 1] = "$r,$c";
          parentNode[r][c + 1] = "$r,$c";
        }
        // Create Open Node..
        if (status[r - 1][c] == unused) {
          status[r - 1][c] = open;
          color[r - 1][c] = Node.border;
          tmpopens.add([r - 1, c]);
          parentNode[r - 1][c] = "$r,$c";
        }
        if (status[r + 1][c] == unused) {
          tmpopens.add([r + 1, c]);
          parentNode[r + 1][c] = "$r,$c";
          color[r + 1][c] = Node.border;
          status[r + 1][c] = open;
        }
        if (status[r][c + 1] == unused) {
          tmpopens.add([r, c + 1]);
          color[r][c + 1] = Node.border;
          status[r][c + 1] = open;
          parentNode[r][c + 1] = "$r,$c";
        }
        if (status[r][c - 1] == unused) {
          tmpopens.add([r, c - 1]);
          color[r][c - 1] = Node.border;
          status[r][c - 1] = open;
          parentNode[r][c - 1] = "$r,$c";
        }
        value[r][c] = min;
        color[r][c] = Node.fill;
        status[r][c] = closed;
        print(arrived);
        await Future.delayed(Duration(microseconds: 100));
        setState(() {});
      } // fro

      opens = tmpopens.toSet().toList();
    } // while

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
                              color[i][j] = Node.start;
                              opens.add([i, j]);
                              value[i][j] = 0;
                              st = true;
                            }
                            if (currentButton == end && !e) {
                              color[i][j] = Node.end;
                              endPosition = [i, j];
                              print(endPosition);
                              e = true;
                            }
                            if (currentButton == barrier) {
                              color[i][j] = Node.barrier;
                              barrierList.add([i,j]);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: color[i][j],
                                border: Border.all(
                                    color: Colors.black12, width: 1)),
                            child: Text(parentNode[i][j].toString()),
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
