import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../features/recipe_recommender/data/models/recipe_model.dart';

class RecipeRemoteDataSource {
  // Lấy cấu hình từ file .env
  final String _apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';
  final String _baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.spoonacular.com';

  // Hàm gọi API: Tìm món ăn theo nguyên liệu
  Future<List<RecipeModel>> findRecipesByIngredients(List<String> ingredients) async {
    // 1. Kiểm tra API Key
    if (_apiKey.isEmpty) throw Exception('Chưa cấu hình API Key trong file .env');
    if (ingredients.isEmpty) return []; // Không có nguyên liệu thì trả về rỗng

    // 2. Tạo URL chuẩn
    // ranking=2: Ưu tiên món giảm thiểu đồ phải mua thêm
    // ignorePantry=true: Bỏ qua kho giả lập của API
    final String ingredientsString = ingredients.join(',').toLowerCase();
    final Uri uri = Uri.parse(
        '$_baseUrl/recipes/findByIngredients?ingredients=$ingredientsString&number=10&ranking=2&ignorePantry=true&apiKey=$_apiKey'
    );

    try {
      print('🌐 Đang gọi API: $uri'); // Log để debug

      // 3. Gửi Request
      final response = await http.get(uri);

      // 4. Xử lý kết quả
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('✅ API trả về ${data.length} món ăn');

        // Convert JSON sang List<RecipeModel>
        return data.map((json) => RecipeModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Lỗi API Key không hợp lệ (401)');
      } else if (response.statusCode == 402) {
        throw Exception('Hết lượt gọi API trong ngày (402)');
      } else {
        throw Exception('Lỗi Server: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Lỗi kết nối: $e');
      rethrow; // Ném lỗi ra ngoài để UI xử lý
    }
  }
}