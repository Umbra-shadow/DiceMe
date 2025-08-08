import 'dart:math';

// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../umbra_utils/design/color.dart';
import '../utils/mapping.dart';

// Dice "3D" animation placeholder
class DiceWidget extends StatelessWidget {
  final int value;
  const DiceWidget({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimaryBlack.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Image.asset('assets/images/dice$value.png')
          .animate(key: ValueKey(value))
          .flip(duration: 500.ms, curve: Curves.easeOut)
          .then(delay: 200.ms)
          .shimmer(
            duration: 500.ms,
            color: AppColors.textPrimaryBlack,
            size: 0.5,
          ),
    );
  }
}

class DiceMeScreen extends StatefulWidget {
  const DiceMeScreen({Key? key}) : super(key: key);

  @override
  State<DiceMeScreen> createState() => _DiceMeScreenState();
}

class _DiceMeScreenState extends State<DiceMeScreen> {
  final Random _rand = Random();
  int d1 = 1;
  int d2 = 1;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    // 2. Dispose of the player when the state is destroyed
    _audioPlayer.dispose();
    super.dispose();
  }

  void rollRandomDice() {
    setState(() {
      d1 = _rand.nextInt(6) + 1;
      d2 = _rand.nextInt(6) + 1;
    });
    // Haptic feedback
    HapticFeedback.heavyImpact();
    // Sound effect
    _audioPlayer.play(AssetSource('sound/dice.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    final int mapped = mapTwoDiceTo1To12(d1, d2);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('DiceMe')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DiceInfoPage(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rules?',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Dice Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textPrimaryBlack.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: DiceWidget(value: d1)),
                  const SizedBox(width: 40),
                  Expanded(child: DiceWidget(value: d2)),
                ],
              ),
            ),
            const SizedBox(height: 60),

            // Mapped Result Display
            Column(
              children: [
                Text('Mapped Result:', style: textTheme.titleMedium),
                const SizedBox(height: 10),
                Text(
                  '$mapped',
                  key: ValueKey('$d1$d2'),
                  style: GoogleFonts.poppins(
                    fontSize: 120,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryWhite,
                    shadows: [
                      BoxShadow(
                        color: AppColors.textPrimaryBlack.withOpacity(0.7),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ).animate().scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                  begin: const Offset(0.5, 0.5),
                ),
              ],
            ),
            const Spacer(),

            // Buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: rollRandomDice,
                  child: const Text('Roll Dice'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mapping');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textPrimaryBlack,
                  ),
                  child: Text(
                    'View Full Mapping',
                    style: textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.textPrimaryBlack,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// This is the new page for displaying the app's rules and information.
class DiceInfoPage extends StatelessWidget {
  const DiceInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundBlack,
        foregroundColor: Colors.white,
        title: const Text('How It Works'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The logic behind the app is simple but unexpected:',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '🔹 The user presses a button labeled “Roll Dice”\n'
                '🔹 Two virtual dice are rolled randomly in the background\n'
                '🔹 These dice values are not shown to the user\n'
                '🔹 Instead, the app applies a custom formula to map the dice pair to a new number between 1 and 12\n'
                '🔹 This mapped number is then displayed boldly to the user',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(color: Colors.white12),
              const SizedBox(height: 20),
              Text(
                'Use this number however you want. It can be a lucky number, a decision-maker, or a mystery challenge. 🎲',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
