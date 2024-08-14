import 'package:flutter/material.dart';
import 'package:get/get.dart';

final infinity = 99999;
final start = "start";
final end = "end";
final barrier = "barrier";
final open = "open";
final closed = "closed";
final unused = "unused";

class BoxController  {
  var value = infinity.obs;
  var color = Colors.black.obs;
  var parentNode;
  var status = unused.obs;

}
