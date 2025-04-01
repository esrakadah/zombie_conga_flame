import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zombie_conga_flame/constants/globals.dart';
import 'package:zombie_conga_flame/game/zombie_conga_game.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({required this.gameRef, super.key});
  static const String id = 'SettingsMenu';
  final ZombieCongaGame gameRef;

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  bool _isAudioEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadAudioSettings();
  }

  Future<void> _loadAudioSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAudioEnabled = prefs.getBool('audioEnabled') ?? true;
    });
    // Sync with game's audio state
    widget.gameRef.toggleAudio(_isAudioEnabled);
  }

  Future<void> _toggleAudio() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAudioEnabled = !_isAudioEnabled;
    });
    await prefs.setBool('audioEnabled', _isAudioEnabled);
    // Sync with game's audio state
    widget.gameRef.toggleAudio(_isAudioEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/${Globals.mainMenuSprite}'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, spreadRadius: 5)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Audio', style: TextStyle(fontSize: 24, color: Colors.black87)),
                        Switch(
                          value: _isAudioEnabled,
                          onChanged: (value) => _toggleAudio(),
                          activeColor: Colors.green,
                          activeTrackColor: Colors.green[200],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      widget.gameRef.overlays.remove(SettingsMenu.id);
                      widget.gameRef.resumeEngine();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 5,
                    ),
                    child: const Text('Back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
