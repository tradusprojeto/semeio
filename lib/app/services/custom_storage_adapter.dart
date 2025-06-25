import 'dart:html';

import 'package:supabase_flutter/supabase_flutter.dart';

class CustomStorageAdapter extends LocalStorage {
  /// Verifica se o localStorage é suportado
  static bool supportsLocalStorage() {
    try {
      window.localStorage['test'] = 'test';
      window.localStorage.remove('test');
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Obtém um item do localStorage
  static String? getItem(String key) {
    if (!supportsLocalStorage()) {
      // Configurar armazenamento alternativo, se necessário
      return null;
    }
    return window.localStorage[key];
  }

  /// Armazena um item no localStorage
  static void setItem(String key, String value) {
    if (!supportsLocalStorage()) {
      // Configurar armazenamento alternativo, se necessário
      return;
    }
    window.localStorage[key] = value;
  }

  /// Remove um item do localStorage
  static void removeItem(String key) {
    if (!supportsLocalStorage()) {
      // Configurar armazenamento alternativo, se necessário
      return;
    }
    window.localStorage.remove(key);
  }

  @override
  Future<String?> accessToken() {
    // TODO: implement accessToken
    throw UnimplementedError();
  }

  @override
  Future<bool> hasAccessToken() {
    // TODO: implement hasAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<void> persistSession(String persistSessionString) {
    // TODO: implement persistSession
    throw UnimplementedError();
  }

  @override
  Future<void> removePersistedSession() {
    // TODO: implement removePersistedSession
    throw UnimplementedError();
  }
}
