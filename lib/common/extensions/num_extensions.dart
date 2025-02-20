extension NumExtensions on num{
  String convertToPercentageString(){
    return '${((this ?? 0) * 10).toStringAsFixed(0)} %';
  }
}