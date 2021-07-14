import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:int_quest/presentation/controllers/example_home_detail/example_home_detail_controller.dart';

class ExampleHomeDetailPage extends GetView<ExampleHomeDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home page detail example"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.username),
              const Center(
                child: SizedBox(
                  height: 20,
                ),
              ),
              Text(controller.password),
            ],
          ),
        ],
      ),
    );
  }
}
