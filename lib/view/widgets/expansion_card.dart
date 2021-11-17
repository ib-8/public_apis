import 'package:flutter/material.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:machine_test/view/web.dart';
import 'package:machine_test/view/widgets/header.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpansionCard extends StatefulWidget {
  const ExpansionCard({
    Key? key,
    required this.category,
    required this.isExpanded,
    required this.onPressed,
  }) : super(key: key);
  final Category category;
  final bool isExpanded;
  final VoidCallback onPressed;

  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> {
  bool openBrowser = false;
  bool showGridView = false;

  void openApi(Api api) {
    if (openBrowser) {
      launch(api.link);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Web(api)));
    }
  }

  void changeGridView() {
    setState(() {
      showGridView = !showGridView;
    });
  }

  void changeWebView() {
    setState(() {
      openBrowser = !openBrowser;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Card(
      color: widget.isExpanded ? Colors.black : Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Header(
            isExpanded: widget.isExpanded,
            showGridView: showGridView,
            openBrowser: openBrowser,
            category: widget.category,
            changeGrideView: changeGridView,
            changeWebView: changeWebView,
            onCardPressed: widget.onPressed,
          ),
          widget.isExpanded
              ? Flexible(
                  child: showGridView
                      ? GridView.builder(
                          padding: const EdgeInsets.only(bottom: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: size.width > size.height ? 3 : 2,
                            childAspectRatio: 2.3,
                          ),
                          itemCount: widget.category.apiList.length,
                          itemBuilder: (_, index) {
                            var api = widget.category.apiList[index];
                            return InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(color: Colors.white),
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
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () => openApi(api),
                            );
                          })
                      : ListView.separated(
                          padding: const EdgeInsets.only(bottom: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.category.apiList.length,
                          separatorBuilder: (_, __) {
                            return const Divider(
                              color: Colors.white,
                              indent: 20,
                              endIndent: 20,
                            );
                          },
                          itemBuilder: (context, index) {
                            var api = widget.category.apiList[index];
                            return ListTile(
                              title: StyledText(
                                api.name,
                                color: Colors.white,
                              ),
                              subtitle: StyledText(
                                api.description,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              onTap: () => openApi(api),
                            );
                          },
                        ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key? key,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.align = TextAlign.start,
  }) : super(key: key);
  final String text;
  final Color color;
  final FontWeight weight;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontWeight: weight,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
