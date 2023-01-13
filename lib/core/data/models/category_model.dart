class DataCategoriesResponse {
  List<CategoryModel> categories;
  int totalCount;

  DataCategoriesResponse({required this.categories, required this.totalCount});

  factory DataCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return DataCategoriesResponse(
      categories: (json['categories'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalCount: json['totalCount'] as int,
    );
  }
}

class CategoryModel {
  final String id;
  final String name;
  bool isSelected;

  CategoryModel({required this.id, required this.name, this.isSelected = false});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, Object> toMap(){
    return {'id':id,'name': name, 'isSelected': isSelected};
  }
}
