import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_model.dart';
import 'edit_profile_sheet.dart';

class ProfileCardPage extends StatefulWidget {
  const ProfileCardPage({super.key});

  @override
  State<ProfileCardPage> createState() => _ProfileCardPageState();
}

class _ProfileCardPageState extends State<ProfileCardPage> {
  ProfileData? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await ProfileRepository.load();
    setState(() => _profile = data);
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _openEditor() async {
    final updated = await showModalBottomSheet<ProfileData>(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditProfileSheet(profile: _profile!),
    );
    if (updated != null) {
      await ProfileRepository.save(updated);
      setState(() => _profile = updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final p = _profile!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card'),
        backgroundColor: const Color(0xFF4A90E2),
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: _openEditor),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth > 480
              ? 480.0
              : constraints.maxWidth * 0.92;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xFF4A90E2),
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: const AssetImage('assets/profile.jpg'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(p.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    _InfoRow(icon: Icons.email, text: p.email),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Icons.phone, text: p.phone),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: p.skills
                          .map((s) => Chip(label: Text(s)))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 32,
                          icon: const Icon(Icons.code),
                          onPressed: () => _launch(p.github),
                        ),
                        IconButton(
                          iconSize: 32,
                          icon: const Icon(Icons.business_center),
                          onPressed: () => _launch(p.linkedin),
                        ),
                        IconButton(
                          iconSize: 32,
                          icon: const Icon(Icons.alternate_email),
                          onPressed: () => _launch(p.twitter),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.grey[800])),
      ],
    );
  }
}