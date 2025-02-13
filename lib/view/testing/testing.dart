// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:prototype/data/network/network_service_api.dart';

// class TestingPage extends StatefulWidget {
//   const TestingPage({super.key});

//   @override
//   State<TestingPage> createState() => _TestingPageState();
// }

// class _TestingPageState extends State<TestingPage> {
//   var data = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Center(
//               child: ElevatedButton(
//                   onPressed: () async {
//                     var h = await NetworkServiceApi()
//                         .getData("http://172.16.2.85:9000/userDetails/");
//                     setState(() async {
//                       data = h;
//                     });
//                   },
//                   child: Text("click me "))),
//           SizedBox(
//             height: 30,
//           ),
//           Container(
//             child: Text(data ?? "dsf"),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:prototype/data/network/network_service_api.dart';
import 'package:prototype/resources/constants/endpoints.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  String data = "Press the button to fetch data";

  Future<void> fetchData() async {
    try {
      var response =
          await NetworkServiceApi().getData(EndPoints.allIndustryCategories);

      setState(() {
        data = response.toString(); // Convert response to string for display
      });
      print(response["data"]["languages"]);
    } catch (error) {
      setState(() {
        data = "Error fetching data: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Testing Page")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: fetchData,
                child: const Text("Click Me"),
              ),
              const SizedBox(height: 30),
              // ElevatedButton(
              //   // onPressed: postData,
              //   child: const Text("Click Me"),
              // ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  data,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
