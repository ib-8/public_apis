import 'package:flutter/material.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:machine_test/view/widgets/expansion_card.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.isExpanded,
    required this.showGridView,
    required this.openBrowser,
    required this.category,
    required this.changeGrideView,
    required this.changeWebView,
    required this.onCardPressed,
  }) : super(key: key);

  final bool isExpanded;
  final bool showGridView;
  final bool openBrowser;
  final Category category;
  final VoidCallback changeGrideView;
  final VoidCallback changeWebView;
  final VoidCallback onCardPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StyledText(
            category.name,
            color: isExpanded ? Colors.white : Colors.black,
            weight: isExpanded ? FontWeight.bold : FontWeight.normal,
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
                    showGridView ? Icons.grid_view_sharp : Icons.list,
                    color: Colors.white,
                  ),
                  onPressed: changeGrideView,
                )
              : const SizedBox(),
          isExpanded
              ? IconButton(
                  icon: Icon(
                    openBrowser ? Icons.language : Icons.open_in_new,
                    color: Colors.white,
                  ),
                  onPressed: changeWebView,
                )
              : const SizedBox(),
          Icon(
            isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: isExpanded ? Colors.white : Colors.black,
          ),
        ],
      ),
      onTap: onCardPressed,
    );
  }
}
