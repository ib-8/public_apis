import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machine_test/model/api_model.dart';

class ApiController {
  static const String _url = 'https://api.publicapis.org/entries';

  static Future<List<Category>> getEntries() async {
    var response = await http.get(Uri.parse(_url));

    Map result = jsonDecode(response.body);
    List entries = result['entries'];

    Map<String, List<Api>> data = {};

    List<Category> categoryList = [];

    for (Map entry in entries) {
      String category = entry['Category'];
      String link = entry['Link'];
      String description = entry['Description'];
      String apiName = entry['API'];

      List<Api> apiList = data[category] ?? [];
      apiList.add(Api(
        link: link,
        name: apiName,
        description: description,
      ));

      data[category] = apiList;
    }

    data.forEach((key, value) {
      categoryList.add(Category(name: key, apiList: value));
    });

    return categoryList;
  }
}
