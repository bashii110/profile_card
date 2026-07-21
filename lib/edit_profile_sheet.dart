import 'package:flutter/material.dart';
import 'profile_model.dart';

class EditProfileSheet extends StatefulWidget {
  final ProfileData profile;
  const EditProfileSheet({super.key, required this.profile});

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _phone;
  late TextEditingController _skills;
  late TextEditingController _github;
  late TextEditingController _linkedin;
  late TextEditingController _twitter;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _name = TextEditingController(text: p.name);
    _email = TextEditingController(text: p.email);
    _phone = TextEditingController(text: p.phone);
    _skills = TextEditingController(text: p.skills.join(', '));
    _github = TextEditingController(text: p.github);
    _linkedin = TextEditingController(text: p.linkedin);
    _twitter = TextEditingController(text: p.twitter);
  }

  void _save() {
    final updated = ProfileData(
      name: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      skills: _skills.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
      github: _github.text.trim(),
      linkedin: _linkedin.text.trim(),
      twitter: _twitter.text.trim(),
    );
    Navigator.pop(context, updated);
  }

  Widget _field(String label, TextEditingController c) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextField(
      controller: c,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _field('Name', _name),
            _field('Email', _email),
            _field('Phone', _phone),
            _field('Skills (comma separated)', _skills),
            _field('GitHub URL', _github),
            _field('LinkedIn URL', _linkedin),
            _field('Twitter URL', _twitter),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _save, child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('Save'),
            )),
          ],
        ),
      ),
    );
  }
}