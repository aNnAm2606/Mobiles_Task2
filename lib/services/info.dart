// ignore_for_file: prefer_typing_uninitialized_variables

class Info {
  final String name;
  final String gender;
  var height;
  var weight;

  Info({required this.name, required this.gender, this.height, this.weight});
}
