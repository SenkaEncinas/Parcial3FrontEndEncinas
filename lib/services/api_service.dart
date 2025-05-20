import 'dart:convert';
import 'package:frontendparcial3/models/Habit/HabitCreateDto';
import 'package:frontendparcial3/models/Habit/HabitDto.dart';
import 'package:frontendparcial3/models/Reflection/ReflectionDto.dart';
import 'package:frontendparcial3/models/user/AssignedUserDto.dart';
import 'package:frontendparcial3/models/user/TokenDto.dart';
import 'package:frontendparcial3/models/user/UserInfoDto.dart';
import 'package:frontendparcial3/models/user/UserLoginDto.dart';
import 'package:frontendparcial3/models/user/UserRegisterDto.dart';

import 'package:http/http.dart' as http;



class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal();

  final String _baseUrl = 'https://app-250519222212.azurewebsites.net/api';
  String? _token;
  UserInfoDto? _currentUser;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  UserInfoDto? get currentUser => _currentUser;

  void _setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
    _currentUser = null;
  }

  // ---------------- Auth ----------------

  Future<void> register(UserRegisterDto dto) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    final res = await http.post(url, headers: _headers, body: jsonEncode(dto.toJson()));
    if (res.statusCode >= 400) {
      throw Exception('Error al registrar usuario: ${res.body}');
    }
  }

  Future<TokenDto> login(UserLoginDto dto) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final res = await http.post(url, headers: _headers, body: jsonEncode(dto.toJson()));
    if (res.statusCode != 200) throw Exception('Login inválido');
    final token = TokenDto.fromJson(jsonDecode(res.body));
    _setToken(token.token);
    return token;
  }

  // ---------------- Usuario actual ----------------

  Future<UserInfoDto> getProfile({bool forceRefresh = false}) async {
    if (!forceRefresh && _currentUser != null) return _currentUser!;
    final url = Uri.parse('$_baseUrl/users');
    final res = await http.get(url, headers: _headers);
    if (res.statusCode != 200) throw Exception('No se pudo obtener el perfil');
    _currentUser = UserInfoDto.fromJson(jsonDecode(res.body));
    return _currentUser!;
  }

  // ---------------- Hábitos ----------------

  Future<List<HabitDto>> getMyHabits() async {
    final url = Uri.parse('$_baseUrl/habits');
    final res = await http.get(url, headers: _headers);
    if (res.statusCode != 200) throw Exception('Error al obtener hábitos');
    final List jsonList = jsonDecode(res.body);
    return jsonList.map((e) => HabitDto.fromJson(e)).toList();
  }

  Future<void> createHabit(HabitCreateDto dto) async {
    final url = Uri.parse('$_baseUrl/habits');
    final res = await http.post(url, headers: _headers, body: jsonEncode(dto.toJson()));
    if (res.statusCode >= 400) throw Exception('Error al crear hábito');
  }

  Future<void> deleteHabit(int id) async {
    final url = Uri.parse('$_baseUrl/habits/$id');
    final res = await http.delete(url, headers: _headers);
    if (res.statusCode != 204) throw Exception('Error al eliminar hábito');
  }

  // ---------------- Reflexiones ----------------

  Future<void> createReflection(ReflectionDto dto) async {
    final url = Uri.parse('$_baseUrl/reflections');
    final res = await http.post(url, headers: _headers, body: jsonEncode(dto.toJson()));
    if (res.statusCode >= 400) throw Exception('Error al guardar reflexión');
  }

  // ---------------- Coach: Usuarios asignados ----------------

  Future<List<AssignedUserDto>> getAssignedUsers() async {
    final url = Uri.parse('$_baseUrl/coach/users');
    final res = await http.get(url, headers: _headers);
    if (res.statusCode != 200) throw Exception('Error al obtener usuarios asignados');
    final List jsonList = jsonDecode(res.body);
    return jsonList.map((e) => AssignedUserDto.fromJson(e)).toList();
  }

  Future<List<HabitDto>> getUserHabits(int userId) async {
    final url = Uri.parse('$_baseUrl/coach/users/$userId/habits');
    final res = await http.get(url, headers: _headers);
    if (res.statusCode != 200) throw Exception('Error al obtener hábitos del usuario');
    final List jsonList = jsonDecode(res.body);
    return jsonList.map((e) => HabitDto.fromJson(e)).toList();
  }

  Future<List<ReflectionDto>> getUserReflections(int userId) async {
    final url = Uri.parse('$_baseUrl/coach/users/$userId/reflections');
    final res = await http.get(url, headers: _headers);
    if (res.statusCode != 200) throw Exception('Error al obtener reflexiones del usuario');
    final List jsonList = jsonDecode(res.body);
    return jsonList.map((e) => ReflectionDto.fromJson(e)).toList();
  }
}
