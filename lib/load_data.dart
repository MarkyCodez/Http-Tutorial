import 'dart:convert';
import 'package:api_integration/model.dart';
import 'package:http/http.dart' as http;

class LoadData {
  static Future<List<DataModel>> getData() async {
    const String url =
        'https://softcodix.pythonanywhere.com/api/serviceprovider/';
    final response = await http.get(
      Uri.parse(
        url,
      ),
    );
    List<dynamic> data = [];
    if (response.statusCode != 200) {
      data = [];
      throw Exception('Failed to load data');
    } else {
      data = jsonDecode(response.body);
    }
    return data.map((e) => DataModel.fromJson(e)).toList();
  }

  Future<void> postData({
    required int id,
    required String name,
    required String comments,
  }) async {
    try {
      final DataModel d2 = DataModel(
        id: id,
        name: name,
        comments: comments,
        deleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        creator: 1,
      );
      final Map<String, dynamic> d1 = d2.toJson();
      const String url =
          'https://softcodix.pythonanywhere.com/api/serviceprovider/';
      await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(d1),
      );
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }

  Future<void> updateData({
    required int id,
    required String name,
    required String comments,
  }) async {
    try {
      final DataModel d2 = DataModel(
        id: id,
        name: name,
        comments: comments,
        deleted: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        creator: 1,
      );
      final Map<String, dynamic> d1 = d2.toJson();
      final String url =
          'https://softcodix.pythonanywhere.com/api/serviceprovider/$id/';
      await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(d1),
      );
      await getData();
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }

  Future<void> deleteData({
    required int id,
  }) async {
    try {
      final String url =
          'https://softcodix.pythonanywhere.com/api/serviceprovider/$id/';
      await http.delete(Uri.parse(url));
      await getData();
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }
}
