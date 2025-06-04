import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/crypto_model.dart';

class LocalStorageService {
  static const _key = 'FAVORITE_CRYPTOS';

  Future<void> saveFavorites(List<CryptoModel> cryptos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = cryptos.map((c) => c.toJson()).toList();
    prefs.setString(_key, json.encode(jsonList));
  }

  Future<List<CryptoModel>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final List decoded = json.decode(jsonString);
    return decoded.map((e) => CryptoModel.fromJson(e)).toList();
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}
