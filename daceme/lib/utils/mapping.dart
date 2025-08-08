int mapTwoDiceTo1To12(int d1, int d2) {
  final int index = (d1 - 1) * 6 + d2;
  final int result = ((index - 1) % 12) + 1;
  return result;
}
