import 'package:contest_app/src/models/category.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

class CategoryProvider {
  final Dio _dio = Dio();

  Future<List<Category>> getCategories(String searchText) async {
    try {
      final response = await _dio.get(
        'https://contest-api.100pay.co/api/v1/contest/search-category',
        queryParameters: {'category': searchText},
      );

      final List<Category> categories = (response.data as List)
          .map((json) => Category.fromJson(json))
          .toList();

      return categories;
    } catch (error) {
      // Handle error
      throw error;
    }
  }
}
