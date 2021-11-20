import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/controller/api_controller.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:machine_test/view/widgets/expansion_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                      categoryIndex: index,
                    );
                  },
                );
        },
      ),
    );
  }
}
