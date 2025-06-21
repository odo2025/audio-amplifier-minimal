import 'package:flutter/material.dart';

void main() {
  runApp(const AudioAmplifierApp());
}

class AudioAmplifierApp extends StatelessWidget {
  const AudioAmplifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Amplifier',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AudioAmplifierHome(),
    );
  }
}

class AudioAmplifierHome extends StatefulWidget {
  const AudioAmplifierHome({super.key});

  @override
  State<AudioAmplifierHome> createState() => _AudioAmplifierHomeState();
}

class _AudioAmplifierHomeState extends State<AudioAmplifierHome> {
  bool _isRunning = false;
  double _amplificationLevel = 0.5;
  double _mixLevel = 0.5;
  double _morphingPosition = 0.5; // 0=Ultra-rapide, 0.5=Équilibré, 1=Haute Qualité

  void _toggleAudio() {
    setState(() {
      _isRunning = !_isRunning;
    });
    // Dans une version future, nous ajouterons ici le code pour démarrer/arrêter l'amplification
  }

  void _updateMorphingPosition(double value) {
    setState(() {
      _morphingPosition = value;
    });
    // Dans une version future, nous ajouterons ici le code pour ajuster la position de morphing
  }

  void _updateAmplification(double value) {
    setState(() {
      _amplificationLevel = value;
    });
    // Dans une version future, nous ajouterons ici le code pour ajuster le niveau d'amplification
  }

  void _updateMixLevel(double value) {
    setState(() {
      _mixLevel = value;
    });
    // Dans une version future, nous ajouterons ici le code pour ajuster le niveau de mixage
  }

  String _getModeText() {
    if (_morphingPosition < 0.33) {
      return "Mode Ultra-rapide";
    } else if (_morphingPosition < 0.67) {
      return "Mode Équilibré";
    } else {
      return "Mode Haute Qualité";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Amplifier'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bouton ON/OFF principal
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _toggleAudio,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: _isRunning ? Colors.red : Colors.green,
                ),
                child: Text(
                  _isRunning ? 'OFF' : 'ON',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Curseur morphing (fader DJ)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _getModeText(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Ultra-rapide'),
                        Expanded(
                          child: Slider(
                            value: _morphingPosition,
                            onChanged: _updateMorphingPosition,
                            divisions: 100,
                          ),
                        ),
                        const Text('Haute Qualité'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Contrôles d'amplification
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Amplification: ${(_amplificationLevel * 100).round()}%',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Slider(
                      value: _amplificationLevel,
                      onChanged: _updateAmplification,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Contrôles de mixage
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Mixage Ambiant/Système: ${(_mixLevel * 100).round()}%',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        const Text('Ambiant'),
                        Expanded(
                          child: Slider(
                            value: _mixLevel,
                            onChanged: _updateMixLevel,
                          ),
                        ),
                        const Text('Système'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
