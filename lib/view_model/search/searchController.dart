import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{
  
RxList userQueue = <dynamic>[].obs;

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
}