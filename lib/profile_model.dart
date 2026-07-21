import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileData {
  String name;
  String email;
  String phone;
  List<String> skills;
  String github;
  String linkedin;
  String twitter;

  ProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.skills,
    required this.github,
    required this.linkedin,
    required this.twitter,
  });

  factory ProfileData.defaultProfile() => ProfileData(
    name: 'Bashir Ahmed',
    email: 'buxhiisd@gmail.com',
    phone: '+923063440645',
    skills: ['Flutter', 'Dart', 'Firebase', 'Git', 'Github', 'Riverpod', 'Laravel'],
    github: 'https://github.com/bashii110',
    linkedin: 'https://linkedin.com/in/bashir-ahmed110',
    twitter: 'https://twitter.com/yourusername',
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'skills': skills,
    'github': github,
    'linkedin': linkedin,
    'twitter': twitter,
  };

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    skills: List<String>.from(json['skills']),
    github: json['github'],
    linkedin: json['linkedin'],
    twitter: json['twitter'],
  );
}

class ProfileRepository {
  static const _key = 'profile_data';

  static Future<ProfileData> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return ProfileData.defaultProfile();
    return ProfileData.fromJson(jsonDecode(raw));
  }

  static Future<void> save(ProfileData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(data.toJson()));
  }
}