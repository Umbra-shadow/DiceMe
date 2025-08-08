import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../umbra_utils/design/color.dart';
import 'mapping.dart';

class MappingView extends StatelessWidget {
  const MappingView({Key? key}) : super(key: key);

  List<String> _getAllMappings() {
    final List<String> rows = [];
    for (int a = 1; a <= 6; a++) {
      for (int b = 1; b <= 6; b++) {
        final r = mapTwoDiceTo1To12(a, b);
        rows.add('($a, $b)  ➜  $r');
      }
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final mappings = _getAllMappings();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Full Mapping Table',
          style: GoogleFonts.orbitron(
            color: AppColors.textSecondaryBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: mappings.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              mappings[index],
              style: GoogleFonts.spaceMono(
                color: AppColors.textPrimaryWhite,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
      ),
    );
  }
}
