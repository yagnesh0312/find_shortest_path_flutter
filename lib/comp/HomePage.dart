import 'package:find_shortest_path/comp/Node.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int row = 25;
  int col = 40;
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
  var value;
  bool st = false;
  bool e = false;
  var color;
  var parentNode;
  var status;
  late List<List<int>> opens;
  late List<int> startPosition;

  late List<List<int>> barrierList;
  List<int>? endPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startPosition = [];
    value = List<List>.generate(row,
        (i) => List<int>.generate(col, (index) => infinity, growable: false),
        growable: false);
    color = List<List>.generate(
        row,
        (i) =>
            List<Color>.generate(col, (index) => Colors.black, growable: false),
        growable: false);
    parentNode = List<List>.generate(
        row, (i) => List<List>.generate(col, (index) => [], growable: false),
        growable: false);
    status = List<List>.generate(row,
        (i) => List<String>.generate(col, (index) => unused, growable: false),
        growable: false);
    opens = [];
    barrierList = [];
  }

  void clear() {
    st = false;
    e = false;
    opens= [];
    barrierList = [];
    startPosition = [];

    for (var i = 0; i < row; i++) {
      for (var j = 0; j < col; j++) {
        value[i][j] = infinity;
        color[i][j] = Colors.black;
        parentNode[i][j] = [];
        status[i][j] = unused;
      }
    }
    setState(() {});
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
      color[startPosition[0]][startPosition[1]] = Colors.green;

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
        // print(status[r - 1][c]);
        if (r - 1 != -1 &&
            status[r - 1][c] != unused &&
            value[r - 1][c] + increase < min) {
          // print("upper");
          min = value[r - 1][c] + increase;
        }
        // bottom main [r + 1][c]
        if (r + 1 != row &&
            status[r + 1][c] != unused &&
            value[r + 1][c] + increase < min) {
          // print("bottom");
          min = value[r + 1][c] + increase;
        }
        // Right main [r][c + 1]
        if (c + 1 != col &&
            status[r][c + 1] != unused &&
            value[r][c + 1] + increase < min) {
          min = value[r][c + 1] + increase;
        }
        // left main [r][c - 1]
        if (c - 1 != -1 &&
            status[r][c - 1] != unused &&
            value[r][c - 1] + increase < min) {
          min = value[r][c - 1] + increase;
        }
        // ?
        // upper left [r-1][c-1]
        if (r - 1 != -1 &&
            c - 1 != -1 &&
            status[r - 1][c - 1] != unused &&
            value[r - 1][c - 1] + increaseDy < min) {
          min = value[r - 1][c - 1] + increaseDy;
        }
        // upper right [r-1][c+1]
        if (r - 1 != -1 &&
            c + 1 != col &&
            status[r - 1][c + 1] != unused &&
            value[r - 1][c + 1] + increaseDy < min) {
          min = value[r - 1][c + 1] + increaseDy;
        }
        // bottom left [r+1][c-1]
        if (r + 1 != row &&
            c - 1 != -1 &&
            status[r + 1][c - 1] != unused &&
            value[r + 1][c - 1] + increaseDy < min) {
          min = value[r + 1][c - 1] + increaseDy;
        }
        // bottom right [r+1][c+1]
        if (r + 1 != row &&
            c + 1 != col &&
            status[r + 1][c + 1] != unused &&
            value[r + 1][c + 1] + increaseDy < min) {
          min = value[r + 1][c + 1] + increaseDy;
        }

        // if start node

        if (status[r][c + 1] == unused &&
            status[r][c - 1] == unused &&
            status[r + 1][c] == unused &&
            status[r - 1][c] == unused &&
            status[r + 1][c + 1] == unused &&
            status[r - 1][c - 1] == unused &&
            status[r + 1][c - 1] == unused &&
            status[r - 1][c + 1] == unused) {
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
          //
          tmpopens.add([r - 1, c - 1]);
          status[r - 1][c - 1] = open;
          color[r - 1][c - 1] = Node.border;
          tmpopens.add([r + 1, c - 1]);
          status[r + 1][c - 1] = open;
          color[r + 1][c - 1] = Node.border;
          tmpopens.add([r - 1, c + 1]);
          status[r - 1][c + 1] = open;
          color[r - 1][c + 1] = Node.border;
          tmpopens.add([r + 1, c + 1]);
          status[r + 1][c + 1] = open;
          color[r + 1][c + 1] = Node.border;

          parentNode[r - 1][c - 1] = [r, c];
          parentNode[r + 1][c - 1] = [r, c];
          parentNode[r + 1][c + 1] = [r, c];
          parentNode[r - 1][c + 1] = [r, c];

          parentNode[r][c - 1] = [r, c];
          parentNode[r][c + 1] = [r, c];
          parentNode[r + 1][c] = [r, c];
          parentNode[r - 1][c] = [r, c];
        }
        // ? Create Open Node..
        if (r - 1 != -1 && status[r - 1][c] == unused) {
          status[r - 1][c] = open;
          color[r - 1][c] = Node.border;
          tmpopens.add([r - 1, c]);
          parentNode[r - 1][c] = [r, c];
        }

        if (r + 1 != row && status[r + 1][c] == unused) {
          tmpopens.add([r + 1, c]);
          parentNode[r + 1][c] = [r, c];
          color[r + 1][c] = Node.border;
          status[r + 1][c] = open;
        }

        if (c + 1 != col && status[r][c + 1] == unused) {
          tmpopens.add([r, c + 1]);
          color[r][c + 1] = Node.border;
          status[r][c + 1] = open;
          parentNode[r][c + 1] = [r, c];
        }

        if (c - 1 != -1 && status[r][c - 1] == unused) {
          tmpopens.add([r, c - 1]);
          color[r][c - 1] = Node.border;
          status[r][c - 1] = open;
          parentNode[r][c - 1] = [r, c];
        }
        // dy
        // upper left [r-1][c-1]
        if (r - 1 != -1 && c - 1 != -1 && status[r - 1][c - 1] == unused) {
          status[r - 1][c - 1] = open;
          color[r - 1][c - 1] = Node.border;
          tmpopens.add([r - 1, c - 1]);
          parentNode[r - 1][c - 1] = [r, c];
        }
        // upper right [r-1][c+1]
        if (r - 1 != -1 && c + 1 != col && status[r - 1][c + 1] == unused) {
          status[r - 1][c + 1] = open;
          color[r - 1][c + 1] = Node.border;
          tmpopens.add([r - 1, c + 1]);
          parentNode[r - 1][c + 1] = [r, c];
        }
        // bottom left [r+1][c-1]
        if (r + 1 != row && c - 1 != -1 && status[r + 1][c - 1] == unused) {
          status[r + 1][c - 1] = open;
          color[r + 1][c - 1] = Node.border;
          tmpopens.add([r + 1, c - 1]);
          parentNode[r + 1][c - 1] = [r, c];
        }
        // bottom right [r+1][c+1]
        if (r + 1 != row && c + 1 != col && status[r + 1][c + 1] == unused) {
          status[r + 1][c + 1] = open;
          color[r + 1][c + 1] = Node.border;
          tmpopens.add([r + 1, c + 1]);
          parentNode[r + 1][c + 1] = [r, c];
        }

        value[r][c] = min;
        color[r][c] = Node.fill;
        status[r][c] = closed;
        if (r == endPosition![0] && c == endPosition![1]) {
          arrived = true;
          break;
        }
        // print(arrived);

        // for visual
        setState(() {});
        await Future.delayed(Duration(milliseconds: 1));
      }
      if (tmpopens.isEmpty) {
        isAvailable = false;
        break;
      }

      opens = tmpopens.toSet().toList();
    } // while
    setState(() {});
    if (!isAvailable) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Container(
                  child: Text("No possible path found!!"),
                ),
              ));
      return;
    }
    int rr = endPosition![0];
    int cc = endPosition![1];
    color[rr][cc] = Node.path;
    color[startPosition[0]][startPosition[1]] = Node.path;
    int rrr = 0;
    int ccc = 0;
    rr = parentNode[rr][cc][0];
    cc = parentNode[rr][cc][1];
    for (var i = 0; !(startPosition[0] == rr && startPosition[1] == cc); i++) {
      color[rr][cc] = Node.path;
      rrr = rr;
      ccc = cc;
      rr = parentNode[rrr][ccc][0];
      cc = parentNode[rrr][ccc][1];
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {});
    }
    DateTime en = DateTime.now();
    var dif = en.difference(strt);
    time = dif.inMilliseconds.toString();
    setState(() {});
    // print(opens);
  }

  @override
  Widget build(BuildContext context) {
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
                          color: Node.start,
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(color: Node.start, blurRadius: 40)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Start Node",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Node.startdark),
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
                            BoxShadow(color: Node.end, blurRadius: 40)
                          ],
                          color: Node.end,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "End Node",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Node.enddark),
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
                          color: Node.barrier,
                          boxShadow: [
                            BoxShadow(color: Node.barrier, blurRadius: 40)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Barrier Node",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Node.barrierdark),
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
                            BoxShadow(color: Node.path, blurRadius: 40)
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
                            GestureDetector(
                              onTap: () {
                                if (currentButton == start && !st) {
                                  color[i][j] = Node.start;
                                  startPosition.add(i);
                                  startPosition.add(j);
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
                                  status[i][j] = barrier;
                                }
                                setState(() {});
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    // shape: value[i][j] == infinity ? BoxShape.circle:BoxShape.rectangle,
                                    color: color[i][j],
                                    boxShadow: [
                                      BoxShadow(
                                        color: color[i][j],
                                        blurRadius: 10,
                                        // blurStyle: BlurStyle.inner
                                        // offset: Offset(10, 10)
                                      )
                                    ],
                                    border: Border.all(
                                        color: Colors.white10, width: 1)),
                                child: Text(
                                  value[i][j] == infinity
                                      ? "∞"
                                      : value[i][j].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: value[i][j] == infinity
                                          ? Colors.white
                                          : Colors.white70),
                                ),
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
        ),
      ),
    );
  }
}
