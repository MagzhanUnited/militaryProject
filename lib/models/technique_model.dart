class TechniqueModel {
  int? id;
  final String name;
  final double src1;
  final double src2;
  final double src3;
  final double src4;
  final bool isBBT;
  TechniqueModel(
      {required this.name,
      required this.src1,
      required this.src2,
      required this.src3,
      required this.src4,
      required this.isBBT});

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'src1':src1,
      'src2':src2,
      'src3':src3,
      'src4':src4,
      'isBBT':isBBT
    };
  }
}
