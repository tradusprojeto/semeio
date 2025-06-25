import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:semeio_app/app/core/formatters/date_formatter.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/model/Child.dart';
import 'package:semeio_app/app/model/Guardian.dart';
import 'package:semeio_app/app/model/Profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseService extends GetxService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final Uuid uuid = const Uuid();

  Future<void> savePost(Map<String, dynamic> data) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception("Usuário nao autenticado");
    }
    Child child = Child(
      id: uuid.v4(),
      firstName: data["childFirstName"],
      birthDate: DateFormatter.toPostgreSql(data["childBirthDate"]),
      cpf: data["childCpf"],
      rg: data["childRg"],
      surname: data["childSurname"],
      email: data["childEmail"],
      sex: data["childSex"],
    );
    Guardian guardian = Guardian(
      id: uuid.v4(),
      fullName: data["guardianName"],
      birthDate: DateFormatter.toPostgreSql(data["guardianBirthDate"]),
      cpf: data["guardianCpf"],
      rg: data["guardianRg"],
      email: data["guardianEmail"],
    );

    child = await saveChild(child);
    guardian = await saveGuardian(guardian);
    var id = uuid.v4();
    Audio newAudio = Audio(
      id: id,
      child: child,
      guardian: guardian,
      urlToAudio: await saveAudio(data["audioBytes"], id),
      transcription: data["transcription"],
      cep: data["cep"],
      state: data["state"],
      city: data["city"],
      district: data["district"],
      latitude: data["latitude"],
      longitude: data["longitude"],
      created_by: user.id,
      created_at: DateTime.now(),
    );
    await _supabaseClient.from("audios").insert(newAudio.toJson());
  }

  Future<String> saveAudio(Uint8List audioBytes, String postId) async {
    String path = "audios/$postId";
    await _supabaseClient.storage.from("semeio_audios").uploadBinary(
          path,
          audioBytes,
          fileOptions: const FileOptions(cacheControl: "3600", upsert: false),
        );
    return path;
  }

  Future<String> editAudioBinary(Uint8List audioBytes, String postId) async {
    String path = "audios/$postId";
    await _supabaseClient.storage.from("semeio_audios").updateBinary(
        path, audioBytes,
        fileOptions: const FileOptions(cacheControl: "3600"));
    return path;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final AuthResponse res = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return res.user;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<User?> signUp(
      final String name, final String email, final String password) async {
    try {
      final AuthResponse response =
          await _supabaseClient.auth.signUp(email: email, password: password);
      var user = response.user;
      if (user == null) {
        throw Exception("Falha ao criar usuário");
      }
      await _supabaseClient.from("profiles").insert({
        "id": user.id,
        "name": name,
        "role": "user",
      });
      return user;
    } catch (err) {
      print("Erro ao cadastrar usuário: $err");
      return null;
    }
  }

  Future<void> sendPasswordResetLinkForEmail(final String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email,
        redirectTo: "http://localhost:40771/#/user/password/update");
  }

  Future<User?> updatePassword(
      final String code, final String newPassword) async {
    try {
      final response = await _supabaseClient.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      return response.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Audio>> getAudiosToBeAudited(int from, int to) async {
    final data = await _supabaseClient
        .from("audios")
        .select('''
        *,
        guardians (*),
        childs (*),
        appraiser: appraiser_id(*),
        edited_by: edited_by(*),
        removed_by: removed_by(*)
    ''')
        .isFilter("validated_at", null)
        .order("created_at", ascending: false)
        .range(from, to);
    return data.map((audio) {
      final Map<String, dynamic> transformedData = {
        ...audio,
        "guardian": audio["guardians"],
        "child": audio["childs"],
        "appraiser": audio["appraiser"],
        "removed_by": audio["removed_by"],
        "edited_by": audio["edited_by"]
      };
      return Audio.fromJson(transformedData);
    }).toList();
  }

  Future<List<Audio>> findAndFilterFromUser(
      Map<String, bool> filters, String searchString) async {
    var query = _supabaseClient.from("audios").select('''
      *,
        guardians!inner(*),
        childs(*),
        appraiser: profiles!inner!appraiser_id(*),
        edited_by: profiles!edited_by(*),
        removed_by: profiles!removed_by(*)
  ''').eq("created_by", getCurrentUser()!.id).filter("deleted_at", "is", null);

    if (filters["cpf"] == true) {
      query = query.ilike("guardians.cpf", searchString);
    }
    if (filters["city"] == true) {
      query = query.filter("city", "ilike", searchString);
    }
    if (filters["created_at"] == true) {
      try {
        final date = DateFormat('dd/MM/yyyy').parseStrict(searchString);
        final dateUTC = date.toUtc();
        final startOfDay = dateUTC.toIso8601String();
        final endOfDay = dateUTC.add(const Duration(days: 1)).toIso8601String();
        query = query.gte("created_at", startOfDay).lt("created_at", endOfDay);
      } on FormatException {
        Get.snackbar("Data mal formatada",
            "A data tem que seguir o seguinte padrão: DD/MM/YYYY");
      } catch (e) {
        print(e);
        rethrow;
      }
    }
    if (filters["appraiserName"] == true) {
      query = query.filter("appraiser.name", "ilike", searchString);
    }

    var data = await query;

    return data.map((audio) {
      final Map<String, dynamic> transformedData = {
        ...audio,
        "guardian": audio["guardians"],
        "child": audio["childs"],
        "appraiser": audio["appraiser"],
        "edited_by": audio["edited_by"],
      };
      return Audio.fromJson(transformedData);
    }).toList();
  }

  Future<List<Audio>> getAudiosAlreadyAudited(int from, int to) async {
    final data = await _supabaseClient
        .from("audios")
        .select('''
        *,
        guardians (*),
        childs (*),
        appraiser: appraiser_id(*),
        edited_by: edited_by(*),
        removed_by: removed_by(*)
    ''')
        .eq("appraiser_id", getCurrentUser()!.id)
        .not("validated_at", "is", "null")
        .order("validated_at", ascending: false)
        .range(from, to);
    return data.map((audio) {
      final Map<String, dynamic> transformedData = {
        ...audio,
        "guardian": audio["guardians"],
        "child": audio["childs"],
        "appraiser": audio["appraiser"],
        "removed_by": audio["removed_by"],
        "edited_by": audio["edited_by"]
      };
      return Audio.fromJson(transformedData);
    }).toList();
  }

  Future<List<Audio>> getAudiosUserFromId(int from, int to) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) return [];
    final data = await _supabaseClient
        .from("audios")
        .select('''
    *,
    guardians (*),
    childs (*),
    appraiser: appraiser_id(*),
    edited_by: edited_by(*),
    removed_by: removed_by(*)
''')
        .eq("created_by", user.id)
        .filter("deleted_at", "is", null)
        .order("created_at", ascending: false)
        .range(from, to);
    return data.map((audio) {
      final Map<String, dynamic> transformedData = {
        ...audio,
        "guardian": audio["guardians"],
        "child": audio["childs"],
        "appraiser": audio["appraiser"],
        "edited_by": audio["edited_by"]
      };
      return Audio.fromJson(transformedData);
    }).toList();
  }

  Future<List<Audio>> getAllAudiosAlreadyAudited() async {
    final data = await _supabaseClient.from("audios").select('''
        *,
        guardians (*),
        childs (*),
        appraiser: appraiser_id(*),
        edited_by: edited_by(*),
        removed_by: removed_by(*)
    ''').not("validated_at", "is", null);
    return data.map((audio) {
      final Map<String, dynamic> transformedData = {
        ...audio,
        "guardian": audio["guardians"],
        "child": audio["childs"],
        "appraiser": audio["appraiser"],
        "removed_by": audio["removed_by"],
        "edited_by": audio["edited_by"]
      };
      return Audio.fromJson(transformedData);
    }).toList();
  }

  Future<int> countItemsToBeAudited() async {
    var res = await _supabaseClient
        .from("audios")
        .select()
        .isFilter("validated_at", null)
        .count();
    return res.count;
  }

  Future<int> countItemsFromUser() async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) return 0;
    final res = await _supabaseClient
        .from("audios")
        .select()
        .eq("created_by", user.id)
        .filter("deleted_at", "is", null)
        .count();
    return res.count;
  }

  Future<Child> saveChild(Child child) async {
    Child? searchedChild;
    if (child.cpf.isNotEmpty) {
      final response = await _supabaseClient
          .from("childs")
          .select()
          .eq("cpf", child.cpf)
          .maybeSingle();
      searchedChild = response != null ? Child.fromJson(response) : null;
    }

    if (searchedChild == null) {
      return Child.fromJson(await _supabaseClient
          .from("childs")
          .insert(child.toJson())
          .select()
          .single());
    }
    return searchedChild;
  }

  Future<Guardian> saveGuardian(Guardian guardian) async {
    Guardian? searchedGuardian;
    if (guardian.cpf.isNotEmpty) {
      final response = await _supabaseClient
          .from("guardians")
          .select()
          .eq("cpf", guardian.cpf)
          .maybeSingle();
      searchedGuardian = response != null ? Guardian.fromJson(response) : null;
    } else if (guardian.email.isNotEmpty) {
      final response = await _supabaseClient
          .from("guardians")
          .select()
          .eq("email", guardian.email)
          .maybeSingle();
      searchedGuardian = response != null ? Guardian.fromJson(response) : null;
    }

    if (searchedGuardian == null) {
      return Guardian.fromJson(await _supabaseClient
          .from("guardians")
          .insert(guardian.toJson())
          .select()
          .single());
    }
    return searchedGuardian;
  }

  Future<int> countItemsAlreadyAudited() async {
    var res = await _supabaseClient
        .from("audios")
        .select()
        .eq("appraiser_id", getCurrentUser()!.id)
        .not("validated_at", "is", null)
        .count();
    return res.count;
  }

  Future<Uint8List?> fetchAudioFromSupabase(String path) async {
    try {
      return await _supabaseClient.storage.from("semeio_audios").download(path);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePost(Audio audio) async {
    await _supabaseClient
        .from("childs")
        .update(audio.child!.toJson())
        .eq("id", audio.child!.id!);

    await _supabaseClient
        .from("guardians")
        .update(audio.guardian!.toJson())
        .eq("id", audio.guardian!.id!);
    await _supabaseClient
        .from("audios")
        .update(audio.toJson())
        .eq("id", audio.id!);
  }

  Future<List<Audio>> findAndFilter(
      Map<String, bool> filters, String searchString) async {
    var query = _supabaseClient.from("audios").select('''
       *,
        guardians!inner(*),
        childs(*),
        appraiser: profiles!inner!appraiser_id(*),
        edited_by: profiles!edited_by(*),
        removed_by: profiles!removed_by(*)
  ''').not("validated_at", "is", null).eq("appraiser_id", getCurrentUser()!.id);

    if (filters["cpf"] == true) {
      query = query.eq("guardians.cpf", searchString);
    }
    if (filters["city"] == true) {
      query = query.ilike("city", searchString);
    }
    if (filters["created_at"] == true) {
      try {
        final date = DateFormat('dd/MM/yyyy').parseStrict(searchString);
        final dateUTC = date.toUtc();
        final startOfDay = dateUTC.toIso8601String();
        final endOfDay = dateUTC.add(const Duration(days: 1)).toIso8601String();
        query = query.gte("created_at", startOfDay).lt("created_at", endOfDay);
      } on FormatException {
        Get.snackbar("Data mal formatada",
            "A data tem que seguir o seguinte padrão: DD/MM/YYYY");
        rethrow;
      } catch (e) {
        rethrow;
      }
    }
    if (filters["appraiser"] == true) {
      query = query.ilike("appraiser.name", searchString);
    }

    var data = await query.order("validated_at", ascending: false);
    return data.map((audio) {
      final Map<String, dynamic> transformedData = {
        ...audio,
        "guardian": audio["guardians"],
        "child": audio["childs"],
        "appraiser": audio["appraiser"],
        "removed_by": audio["removed_by"],
        "edited_by": audio["edited_by"]
      };
      return Audio.fromJson(transformedData);
    }).toList();
  }

  Future<String?> getUserRole() async {
    final user = _supabaseClient.auth.currentUser;

    if (user == null) return null;

    final response = await _supabaseClient
        .from("profiles")
        .select("role")
        .eq("id", user.id)
        .single();
    return response["role"];
  }

  Future<bool> checkIfNameIsProvided() async {
    final user = _supabaseClient.auth.currentUser;

    final response = await _supabaseClient
        .from("profiles")
        .select("*")
        .eq("id", user!.id)
        .single();
    return response["name"] == null || response["name"].isEmpty ? false : true;
  }

  Future<void> updateUserProfileName(String newName) async {
    try {
      final User? user = _supabaseClient.auth.currentUser;

      if (user == null) {
        throw Exception("Usuário não autenticado");
      }

      final response = await _supabaseClient
          .from("profiles")
          .update({"name": newName}).eq("id", user.id);

      if (response.error != null) {
        throw Exception("Erro ao atualizar: ${response.error!.message}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Profile> getUser(String id) async {
    final response = await _supabaseClient
        .from("profiles")
        .select("*")
        .eq("id", id)
        .single();

    return Profile.fromJson(response);
  }

  User? getCurrentUser() {
    return _supabaseClient.auth.currentUser;
  }

  Future<Audio> getAudio(String audioId) async {
    final data = await _supabaseClient.from("audios").select('''
        *,
        guardians (*),
        childs (*),
        appraiser: appraiser_id(*),
        edited_by: edited_by(*),
        removed_by: removed_by(*)
    ''').eq("id", audioId).single();
    final Map<String, dynamic> transformedData = {
      ...data,
      "guardian": data["guardians"],
      "child": data["childs"],
      "appraiser": data["appraiser"],
      "edited_by": data["edited_by"],
      "removed_by": data["removed_by"]
    };

    return Audio.fromJson(transformedData);
  }

  Future<String> getRole(String userId) async {
    final data = await _supabaseClient
        .from("profiles")
        .select("*")
        .eq("id", userId)
        .single();
    return data["role"];
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (err) {
      rethrow;
    }
  }
}
