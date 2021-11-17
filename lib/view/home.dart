import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/controller/api_controller.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:machine_test/view/widgets/expansion_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int openedCard = 0;
  bool isExpanded = false;

  void onCardPressed(int index) async {
    if (index == openedCard && isExpanded) {
      isExpanded = false;
    } else {
      isExpanded = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public APIs'),
      ),
      body: FutureBuilder<List<Category>>(
        future: ApiController.getEntries(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var category = snapshot.data![index];
                    return ExpansionCard(
                      category: category,
                      isExpanded: isExpanded && index == openedCard,
                      onPressed: () => onCardPressed(index),
                    );
                  },
                );
        },
      ),
    );
  }
}
