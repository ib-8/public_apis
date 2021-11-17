import 'package:flutter/material.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {
  const Web(this.api, {Key? key}) : super(key: key);

  final Api api;

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.api.name),
      ),
      body: Column(
        children: [
          isLoading
              ? LinearProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black.withOpacity(0.5),
                )
              : const SizedBox(),
          Flexible(
            child: WebView(
              initialUrl: widget.api.link,
              javascriptMode: JavascriptMode.unrestricted,
              onProgress: (value) {
                if (value == 100) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
