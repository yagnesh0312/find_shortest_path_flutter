import 'package:find_shortest_path/comp/Node.dart';
import 'package:find_shortest_path/comp/box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final increase = 10;
final increaseDy = 14;
final infinity = 99999;
final start = "start";
final end = "end";
final barrier = "barrier";
final open = "open";
final closed = "closed";
final unused = "unused";
var currentButton = "";
var time = "";

class abc extends StatelessWidget {
  const abc({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// class Home extends StatefulWidget {
//   const Home({super.key});
//   @override
//   State<Home> createState() => _HomeState();
// }

class Home extends StatelessWidget {
  int row = 25;
  int col = 40;

  // var value;
  bool st = false;
  bool e = false;
  // var color;
  // var parentNode;
  // var status;
  late List<List<BoxController>> nodes;
  late List<List<int>> opens;
  late List<int> startPosition;
  late List<List<int>> barrierList;
  List<int>? endPosition;
  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    // value = List<List>.generate(row,
    //     (i) => List<int>.generate(col, (index) => infinity, growable: false),
    //     growable: false);
    // color = List<List>.generate(
    //     row,
    //     (i) =>
    //         List<Color>.generate(col, (index) => Colors.black, growable: false),
    //     growable: false);
    // parentNode = List<List>.generate(
    //     row, (i) => List<List>.generate(col, (index) => [], growable: false),
    //     growable: false);
    // status = List<List>.generate(row,
    //     (i) => List<String>.generate(col, (index) => unused, growable: false),
    //     growable: false);
  }

  void clear() {
    st = false;
    e = false;
    opens = [];
    barrierList = [];
    startPosition = [];

    for (var i = 0; i < row; i++) {
      for (var j = 0; j < col; j++) {
        nodes[i][j].value.value = infinity;
        nodes[i][j].color.value = Colors.black;
        nodes[i][j].parentNode = [];
        nodes[i][j].status.value = unused;
      }
    }
    // setState(() {});
  }

  void play() async {
    bool isAvailable = true;
    if (endPosition == null) {
      return;
    }
    int r, c;
    late List<List<int>> tmpopens = [];
    bool arrived = false;
    DateTime strt = DateTime.now();
    while (!arrived && isAvailable) {
      nodes[startPosition[0]][startPosition[1]].color.value = Colors.green;

      tmpopens = [];
      // print("not Arrived");
      for (var i = 0; i < opens.length; i++) {
        r = opens[i][0];
        c = opens[i][1];
        print("$r = ${endPosition![0]} and $c = ${endPosition![1]}");
        if (r == endPosition![0] && c == endPosition![1]) {
          arrived = true;
        }
        int min = infinity;
        // ? set open Value
        // upper main [r - 1][c]
        // print(nodes[r - 1][c].status.value);
        if (r - 1 != -1 &&
            nodes[r - 1][c].status.value != unused &&
            nodes[r - 1][c].value.value + increase < min) {
          // print("upper");
          min = nodes[r - 1][c].value.value + increase;
        }
        // bottom main [r + 1][c]
        if (r + 1 != row &&
            nodes[r + 1][c].status.value != unused &&
            nodes[r + 1][c].value.value + increase < min) {
          // print("bottom");
          min = nodes[r + 1][c].value.value + increase;
        }
        // Right main [r][c + 1]
        if (c + 1 != col &&
            nodes[r][c + 1].status.value != unused &&
            nodes[r][c + 1].value.value + increase < min) {
          min = nodes[r][c + 1].value.value + increase;
        }
        // left main [r][c - 1]
        if (c - 1 != -1 &&
            nodes[r][c - 1].status.value != unused &&
            nodes[r][c - 1].value.value + increase < min) {
          min = nodes[r][c - 1].value.value + increase;
        }
        // ?
        // upper left [r-1][c-1]
        if (r - 1 != -1 &&
            c - 1 != -1 &&
            nodes[r - 1][c - 1].status.value != unused &&
            nodes[r - 1][c - 1].value.value + increaseDy < min) {
          min = nodes[r - 1][c - 1].value.value + increaseDy;
        }
        // upper right [r-1][c+1]
        if (r - 1 != -1 &&
            c + 1 != col &&
            nodes[r - 1][c + 1].status.value != unused &&
            nodes[r - 1][c + 1].value.value + increaseDy < min) {
          min = nodes[r - 1][c + 1].value.value + increaseDy;
        }
        // bottom left [r+1][c-1]
        if (r + 1 != row &&
            c - 1 != -1 &&
            nodes[r + 1][c - 1].status.value != unused &&
            nodes[r + 1][c - 1].value.value + increaseDy < min) {
          min = nodes[r + 1][c - 1].value.value + increaseDy;
        }
        // bottom right [r+1][c+1]
        if (r + 1 != row &&
            c + 1 != col &&
            nodes[r + 1][c + 1].status.value != unused &&
            nodes[r + 1][c + 1].value.value + increaseDy < min) {
          min = nodes[r + 1][c + 1].value.value + increaseDy;
        }

        // if start node

        if (nodes[r][c + 1].status.value == unused &&
            nodes[r][c - 1].status.value == unused &&
            nodes[r + 1][c].status.value == unused &&
            nodes[r - 1][c].status.value == unused &&
            nodes[r + 1][c + 1].status.value == unused &&
            nodes[r - 1][c - 1].status.value == unused &&
            nodes[r + 1][c - 1].status.value == unused &&
            nodes[r - 1][c + 1].status.value == unused) {
          min = 0;
          tmpopens.add([r - 1, c]);
          nodes[r - 1][c].status.value = open;
          nodes[r - 1][c].color.value = property.border;
          tmpopens.add([r + 1, c]);
          nodes[r + 1][c].status.value = open;
          nodes[r + 1][c].color.value = property.border;
          tmpopens.add([r, c + 1]);
          nodes[r][c + 1].status.value = open;
          nodes[r][c + 1].color.value = property.border;
          tmpopens.add([r, c - 1]);
          nodes[r][c - 1].status.value = open;
          nodes[r][c - 1].color.value = property.border;
          //
          tmpopens.add([r - 1, c - 1]);
          nodes[r - 1][c - 1].status.value = open;
          nodes[r - 1][c - 1].color.value = property.border;
          tmpopens.add([r + 1, c - 1]);
          nodes[r + 1][c - 1].status.value = open;
          nodes[r + 1][c - 1].color.value = property.border;
          tmpopens.add([r - 1, c + 1]);
          nodes[r - 1][c + 1].status.value = open;
          nodes[r - 1][c + 1].color.value = property.border;
          tmpopens.add([r + 1, c + 1]);
          nodes[r + 1][c + 1].status.value = open;
          nodes[r + 1][c + 1].color.value = property.border;

          nodes[r - 1][c - 1].parentNode = [r, c];
          nodes[r + 1][c - 1].parentNode = [r, c];
          nodes[r + 1][c + 1].parentNode = [r, c];
          nodes[r - 1][c + 1].parentNode = [r, c];

          nodes[r][c - 1].parentNode = [r, c];
          nodes[r][c + 1].parentNode = [r, c];
          nodes[r + 1][c].parentNode = [r, c];
          nodes[r - 1][c].parentNode = [r, c];
        }
        // ? Create Open Node..
        if (r - 1 != -1 && nodes[r - 1][c].status.value == unused) {
          nodes[r - 1][c].status.value = open;
          nodes[r - 1][c].color.value = property.border;
          tmpopens.add([r - 1, c]);
          nodes[r - 1][c].parentNode = [r, c];
        }

        if (r + 1 != row && nodes[r + 1][c].status.value == unused) {
          tmpopens.add([r + 1, c]);
          nodes[r + 1][c].parentNode = [r, c];
          nodes[r + 1][c].color.value = property.border;
          nodes[r + 1][c].status.value = open;
        }

        if (c + 1 != col && nodes[r][c + 1].status.value == unused) {
          tmpopens.add([r, c + 1]);
          nodes[r][c + 1].color.value = property.border;
          nodes[r][c + 1].status.value = open;
          nodes[r][c + 1].parentNode = [r, c];
        }

        if (c - 1 != -1 && nodes[r][c - 1].status.value == unused) {
          tmpopens.add([r, c - 1]);
          nodes[r][c - 1].color.value = property.border;
          nodes[r][c - 1].status.value = open;
          nodes[r][c - 1].parentNode = [r, c];
        }
        // dy
        // upper left [r-1][c-1]
        if (r - 1 != -1 &&
            c - 1 != -1 &&
            nodes[r - 1][c - 1].status.value == unused) {
          nodes[r - 1][c - 1].status.value = open;
          nodes[r - 1][c - 1].color.value = property.border;
          tmpopens.add([r - 1, c - 1]);
          nodes[r - 1][c - 1].parentNode = [r, c];
        }
        // upper right [r-1][c+1]
        if (r - 1 != -1 &&
            c + 1 != col &&
            nodes[r - 1][c + 1].status.value == unused) {
          nodes[r - 1][c + 1].status.value = open;
          nodes[r - 1][c + 1].color.value = property.border;
          tmpopens.add([r - 1, c + 1]);
          nodes[r - 1][c + 1].parentNode = [r, c];
        }
        // bottom left [r+1][c-1]
        if (r + 1 != row &&
            c - 1 != -1 &&
            nodes[r + 1][c - 1].status.value == unused) {
          nodes[r + 1][c - 1].status.value = open;
          nodes[r + 1][c - 1].color.value = property.border;
          tmpopens.add([r + 1, c - 1]);
          nodes[r + 1][c - 1].parentNode = [r, c];
        }
        // bottom right [r+1][c+1]
        if (r + 1 != row &&
            c + 1 != col &&
            nodes[r + 1][c + 1].status.value == unused) {
          nodes[r + 1][c + 1].status.value = open;
          nodes[r + 1][c + 1].color.value = property.border;
          tmpopens.add([r + 1, c + 1]);
          nodes[r + 1][c + 1].parentNode = [r, c];
        }

        nodes[r][c].value.value = min;
        nodes[r][c].color.value = property.fill;
        nodes[r][c].status.value = closed;
        if (r == endPosition![0] && c == endPosition![1]) {
          arrived = true;
          break;
        }
        // print(arrived);

        // for visual
        // setState(() {});
        await Future.delayed(Duration.zero);
      }
      if (tmpopens.isEmpty) {
        isAvailable = false;
        break;
      }

      opens = tmpopens.toSet().toList();
    } // while
    // setState(() {});
    if (!isAvailable) {
      Get.defaultDialog(
          title: "Not Found", content: Text("No possible path found!!"));

      return;
    }
    int rr = endPosition![0];
    int cc = endPosition![1];
    nodes[rr][cc].color.value = property.path;
    nodes[startPosition[0]][startPosition[1]].color.value = property.path;
    int rrr = 0;
    int ccc = 0;
    rr = nodes[rr][cc].parentNode[0];
    cc = nodes[rr][cc].parentNode[1];
    for (var i = 0; !(startPosition[0] == rr && startPosition[1] == cc); i++) {
      nodes[rr][cc].color.value = property.path;
      rrr = rr;
      ccc = cc;
      rr = nodes[rrr][ccc].parentNode[0];
      cc = nodes[rrr][ccc].parentNode[1];
      // await Future.delayed(Duration(milliseconds: 10));
      // setState(() {});
    }
    DateTime en = DateTime.now();
    var dif = en.difference(strt);
    time = dif.inMilliseconds.toString();
    // setState(() {});
    // print(opens);
  }

  @override
  Widget build(BuildContext context) {
    startPosition = [];
    nodes = List<List<BoxController>>.generate(
        row,
        (i) => List<BoxController>.generate(col, (i) => BoxController(),
            growable: false));
    opens = [];
    barrierList = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        toolbarHeight: 150,
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(height: 30),
            Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Dijkstra's algorithm Visualizer",
                    style: TextStyle(
                        shadows: [Shadow(color: Colors.white, blurRadius: 40)],
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "By Yagnesh Jariwala",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 15),
                  ),
                ]),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: property.start,
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(color: property.start, blurRadius: 40)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Start Node",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: property.startdark),
                      ),
                    ),
                    onPressed: () {
                      currentButton = "start";
                    }),
                CupertinoButton(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(color: property.end, blurRadius: 40)
                          ],
                          color: property.end,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "End Node",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: property.enddark),
                      ),
                    ),
                    onPressed: () {
                      currentButton = "end";
                    }),
                CupertinoButton(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: property.barrier,
                          boxShadow: [
                            BoxShadow(color: property.barrier, blurRadius: 40)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Barrier Node",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: property.barrierdark),
                      ),
                    ),
                    onPressed: () {
                      currentButton = "barrier";
                    }),
                CupertinoButton(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(color: property.path, blurRadius: 40)
                          ],
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Play Visualizer",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      play();
                    }),
                CupertinoButton(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(color: Colors.white, blurRadius: 40)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Clear",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      clear();
                    }),

                // time != "" ? Text("Time: " + time + " ms",style: TextStyle(fontWeight:FontWeight.w800,color: Colors.white),) : Container(),
              ],
            ),
          ],
        ),
      ),
      body: MouseRegion(
        cursor: SystemMouseCursors.precise,
        child: Container(
          child: Center(
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
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  if (currentButton == start && !st) {
                                    nodes[i][j].color.value = property.start;
                                    startPosition.add(i);
                                    startPosition.add(j);
                                    opens.add([i, j]);
                                    nodes[i][j].value.value = 0;
                                    st = true;
                                  }
                                  if (currentButton == end && !e) {
                                    nodes[i][j].color.value = property.end;
                                    endPosition = [i, j];
                                    print(endPosition);
                                    e = true;
                                  }
                                  if (currentButton == barrier) {
                                    nodes[i][j].color.value = property.barrier;
                                    nodes[i][j].status.value = barrier;
                                  }
                                  // setState(() {});
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      // shape: nodes[i][j].value.value == infinity ? BoxShape.circle:BoxShape.rectangle,
                                      color: nodes[i][j].color.value,
                                      boxShadow: [
                                        BoxShadow(
                                          color: nodes[i][j].color.value,
                                          blurRadius: 10,
                                          // blurStyle: BlurStyle.inner
                                          // offset: Offset(10, 10)
                                        )
                                      ],
                                      border: Border.all(
                                          color: Colors.white10, width: 1)),
                                  child: Text(
                                    nodes[i][j].value.value == infinity
                                        ? "∞"
                                        : nodes[i][j].value.value.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color:
                                            nodes[i][j].value.value == infinity
                                                ? Colors.white
                                                : Colors.white70),
                                  ),
                                ),
                              ),
                            )
                          ]
                        ],
                      )
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
