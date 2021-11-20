import 'package:flutter/material.dart';
import 'package:machine_test/controller/home_view_controller.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:machine_test/view/widgets/styled_text.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.category,
    required this.index,
    required this.homeViewController,
  }) : super(key: key);

  final Category category;
  final int index;
  final HomeViewController homeViewController;

  @override
  Widget build(BuildContext context) {
    var homeView = homeViewController.value;
    bool isExpanded = homeView.isExpanded && homeView.openedCardIndex == index;
    return ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: StyledText(
                category.name,
                color: isExpanded ? Colors.white : Colors.black,
                weight: isExpanded ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 5),
            Card(
              shape: const CircleBorder(),
              color: isExpanded ? Colors.white : Colors.black,
              child: Padding(
                padding: EdgeInsets.all(category.apiList.length > 99
                    ? 5.0
                    : category.apiList.length > 9
                        ? 4.0
                        : 8.0),
                child: StyledText(
                  category.apiList.length.toString(),
                  color: isExpanded ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isExpanded
                ? IconButton(
                    icon: Icon(
                      homeView.showGridView
                          ? Icons.grid_view_sharp
                          : Icons.list,
                      color: Colors.white,
                    ),
                    onPressed: homeViewController.changeGridView,
                  )
                : const SizedBox(),
            isExpanded
                ? IconButton(
                    icon: Icon(
                      homeView.openBrowser ? Icons.language : Icons.open_in_new,
                      color: Colors.white,
                    ),
                    onPressed: homeViewController.changeWebView,
                  )
                : const SizedBox(),
            Icon(
              isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: isExpanded ? Colors.white : Colors.black,
            ),
          ],
        ),
        onTap: () {
          homeViewController.changeExpandState(index);
        });
  }
}
