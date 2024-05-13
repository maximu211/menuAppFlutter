import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menuapp/http/DTOs/DTOs.dart';
import 'package:menuapp/http/DTOs/result.dart';
import 'package:menuapp/http/routes.dart';
import 'package:menuapp/utils/secure_storage.dart';

class RecipeRequests {
  static Future<ServiceResult> createRecipe(FullRecipeDto recipe) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.createRecipe);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(recipe),
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<CardRecipeDto> getRecipesByUserId(String userId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.getRecipesByUserId);
    stringBuffer.write("/$userId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return CardRecipeDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<CardRecipeDto> getRecipesBySubs() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.getRecipesBySubs);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return CardRecipeDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<CardRecipeDto> getSavedRecipes() async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.getSavedRecipes);

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return CardRecipeDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> deleteRecipe(String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.deleteRecipe);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.delete(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> updateRecipe(
      String recipeId, FullRecipeDto recipe) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.updateRecipe);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.put(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> likeRecipe(String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.likeRecipe);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> saveRecipe(String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.saveRecipe);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> dislikeRecipe(String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.dislikeRecipe);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<ServiceResult> deleteRecipeFromSaved(String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.deleteFromSaved);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.post(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return ServiceResult.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<RecipeDescriptionElementsDto> getRecipeDetails(
      String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.getRecipeDetails);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return RecipeDescriptionElementsDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  static Future<FullRecipeDto> getRecipeById(String recipeId) async {
    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(BaseRoutes.baseUrl);
    stringBuffer.write(BaseRoutes.recipe);
    stringBuffer.write(RecipeRoutes.deleteFromSaved);
    stringBuffer.write("/$recipeId");

    final String? accessToken =
        await SecureStorage().storage.read(key: "AccessToken");

    final response = await http.get(
      Uri.parse(stringBuffer.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    return FullRecipeDto.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
