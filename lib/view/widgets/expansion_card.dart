import 'package:flutter/material.dart';
import 'package:machine_test/controller/home_view_controller.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:machine_test/view/widgets/header.dart';
import 'package:machine_test/view/widgets/styled_text.dart';

class ExpansionCard extends StatelessWidget {
  ExpansionCard({
    Key? key,
    required this.category,
    required this.categoryIndex,
  }) : super(key: key);
  final Category category;
  final int categoryIndex;
  final HomeViewController homeViewController = HomeViewController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ValueListenableBuilder<HomeView>(
        valueListenable: homeViewController,
        builder: (context, value, child) {
          bool isExpanded =
              value.isExpanded && value.openedCardIndex == categoryIndex;
          return Card(
            color: isExpanded ? Colors.black : Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Header(
                  category: category,
                  index: categoryIndex,
                  homeViewController: homeViewController,
                ),
                isExpanded
                    ? Flexible(
                        child: value.showGridView
                            ? GridView.builder(
                                padding: const EdgeInsets.only(bottom: 15),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      size.width > size.height ? 3 : 2,
                                  childAspectRatio: 2.3,
                                ),
                                itemCount: category.apiList.length,
                                itemBuilder: (_, index) {
                                  var api = category.apiList[index];
                                  return InkWell(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            StyledText(
                                              api.name,
                                              color: Colors.white,
                                              align: TextAlign.center,
                                            ),
                                            const SizedBox(height: 3),
                                            Flexible(
                                              child: StyledText(
                                                api.description,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () => homeViewController.openApi(
                                        context, api),
                                  );
                                })
                            : ListView.separated(
                                padding: const EdgeInsets.only(bottom: 15),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: category.apiList.length,
                                separatorBuilder: (_, __) {
                                  return const Divider(
                                    color: Colors.white,
                                    indent: 20,
                                    endIndent: 20,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  var api = category.apiList[index];
                                  return ListTile(
                                    title: StyledText(
                                      api.name,
                                      color: Colors.white,
                                    ),
                                    subtitle: StyledText(
                                      api.description,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                    onTap: () => homeViewController.openApi(
                                        context, api),
                                  );
                                },
                              ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        });
  }
}
