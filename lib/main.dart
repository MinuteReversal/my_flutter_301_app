import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (Object error, StackTrace stackTrace) {
    print(
        error); //output in Android Studio => Logcat => Null check operator used on a null value
    print(
        stackTrace); // 2022-06-18 16:43:54.739 24609-24638/? I/flutter: #0      _PagePosition.applyViewportDimension (package:flutter/src/widgets/page_view.dart:455)
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'First'),
    Tab(text: 'Second'),
    Tab(text: 'Third'),
  ];

  late final TabController tabController = TabController(
    vsync: this,
    length: tabs.length,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TabBar(
              tabs: tabs,
              isScrollable: true,
              controller: tabController,
              labelColor: const Color.fromARGB(255, 56, 56, 56),
              labelPadding: const EdgeInsets.symmetric(horizontal: 10),
              indicatorColor: const Color.fromARGB(255, 59, 205, 225),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: tabs.map<Widget>(
                (Tab tab) {
                  return Center(child: Text(tab.text ?? ''));
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
