class Api {
  final String link;
  final String name;
  final String description;

  Api({required this.link, required this.name, required this.description});
}

class Category {
  final String name;
  final List<Api> apiList;

  Category({required this.name, required this.apiList});
}
