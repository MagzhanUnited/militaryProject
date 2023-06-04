import 'package:flutter_application_kr/models/guns_models.dart';
import 'package:flutter_application_kr/models/technique_model.dart';

class AllModels {
  bool isAtack;
  late TechniqueModel srcTank;
  late TechniqueModel srcBMP;
  late TechniqueModel srcSAU;
  late TechniqueModel srcBTR;

  AllModels({required this.isAtack}) {
    srcTank = TechniqueModel(
      isBBT: true,
      name: 'Tank',
      src1: isAtack ? 3.3 : 1.9,
      src2: isAtack ? 2 : 1.5,
      src3: isAtack ? 1.6 : 0.8,
      src4: isAtack ? 2.2 : 1.4,
    );

    srcBMP = TechniqueModel(
      name: 'БМП',
      src1: isAtack ? 2.8 : 2,
      src2: isAtack ? 1.7 : 1.2,
      src3: isAtack ? 1.1 : 0.6,
      src4: isAtack ? 1.7 : 1.2,
      isBBT: true,
    );

    srcSAU = TechniqueModel(
      name: 'САУ',
      src1: isAtack ? 1.9 : 1.5,
      src2: isAtack ? 1.2 : 0.8,
      src3: isAtack ? 0.6 : 0.4,
      src4: isAtack ? 0.8 : 0.6,
      isBBT: true,
    );

    srcBTR = TechniqueModel(
      name: 'БТР',
      src1: isAtack ? 2.5 : 1.8,
      src2: isAtack ? 1.3 : 0.9,
      src3: isAtack ? 0.9 : 0.9,
      src4: isAtack ? 1.3 : 0.7,
      isBBT: true,
    );
  }
}

class AllGuns {
  ConParts conParts1 = ConParts(
      guns: Guns(
        name:
            'К наземной буксируемой и самоходной артиллерии, буксируемым и самоходным минометам',
        kig: 0.8,
        inBrigade: 0.5,
        inParts: 1.5,
      ),
      name: 'Мотострелковые(механизированные) бригады');
  ConParts conParts2 = ConParts(
      guns: Guns(
        name: 'К реактивным системам залпового огня',
        kig: 0.8,
        inBrigade: 0.5,
        inParts: 1,
      ),
      name: 'Мотострелковые(механизированные) бригады');
  ConParts conParts3 = ConParts(
      guns: Guns(
        name: 'К противотанковым ракетным комплексам',
        kig: 0.6,
        inBrigade: 0.5,
        inParts: 1,
      ),
      name: 'Мотострелковые(механизированные) бригады');
  ConParts conParts4 = ConParts(
      guns: Guns(
        name:
            'К танкам, самоходным установкам, боевым машинам пехоты и бронетранспортерам',
        kig: 0.6,
        inBrigade: 0.5,
        inParts: 1.5,
      ),
      name: 'Мотострелковые(механизированные) бригады');
  ConParts conParts5 = ConParts(
      guns: Guns(
          name: 'К зенитному вооружению', kig: 1, inBrigade: 0.5, inParts: 2),
      name: 'Мотострелковые(механизированные) бригады');
  ConParts conParts6 = ConParts(
      guns: Guns(
        name:
            'К стрелковому оружию, гранатометам, ручные и реактивные гранаты, kig: 1,сигнальные, осветительные изондировочные патроны',
        kig: 1,
        inBrigade: 0.25,
        inParts: 1,
      ),
      name: 'Мотострелковые(механизированные) бригады');
  ConParts conParts7 = ConParts(
      guns: Guns(
          name: 'К реактивным системам залпового огня',
          kig: 0.8,
          inBrigade: null,
          inParts: 1),
      name: 'Десантно-штурмовые бригады………');
  ConParts conParts8 = ConParts(
      guns: Guns(
          name: 'К противотанковым ракетным комплексам',
          kig: 0.6,
          inBrigade: 0.5,
          inParts: 1.5),
      name: 'Десантно-штурмовые бригады………');
  ConParts conParts9 = ConParts(
      guns: Guns(
          name: 'К зенитному вооружению',
          kig: 1,
          inBrigade: 0.25,
          inParts: 1.75),
      name: 'Десантно-штурмовые бригады………');
  ConParts conParts10 = ConParts(
      guns: Guns(
          name:
              'К наземной буксируемой и самоходной артиллерии, буксируемым и самоходным минометам',
          kig: 0.8,
          inBrigade: 0.25,
          inParts: 1.25),
      name: 'Отдельные мотострелковые и механизированные бригады……….');
  ConParts conParts11 = ConParts(
      guns: Guns(
          name: 'К реактивным системам залпового огня',
          kig: 0.8,
          inBrigade: 0.3,
          inParts: 1),
      name: 'Отдельные мотострелковые и механизированные бригады……….');
  ConParts conParts12 = ConParts(
      guns: Guns(
          name: 'К противотанковым ракетным комплексам',
          kig: 0.6,
          inBrigade: 0.15,
          inParts: 1),
      name: 'Отдельные мотострелковые и механизированные бригады……….');
  ConParts conParts13 = ConParts(
      guns: Guns(
          name:
              'К танкам, самоходным установкам, боевым машинам пехоты и бронетранспортерам',
          kig: 0.6,
          inBrigade: 0.5,
          inParts: 1.5),
      name: 'Отдельные мотострелковые и механизированные бригады……….');
  ConParts conParts14 = ConParts(
      guns: Guns(
          name: 'К зенитному вооружению', kig: 1, inBrigade: 0.5, inParts: 2),
      name: 'Отдельные мотострелковые и механизированные бригады……….');
  ConParts conParts15 = ConParts(
      guns: Guns(
          name:
              'К стрелковому оружию, гранатометам, ручные и реактивные гранаты, kig: 1,сигнальные, осветительные изондировочные патроны',
          kig: 1,
          inBrigade: 0.25,
          inParts: 1),
      name: 'Отдельные мотострелковые и механизированные бригады……….');

  ConParts conParts16 = ConParts(
      guns: Guns(
          name:
              'К наземной буксируемой и самоходной артиллерии, буксируемым и самоходным минометам',
          kig: 0.8,
          inBrigade: null,
          inParts: 1.5),
      name: 'Отдельные мотострелковые и механизированные бригады (батальоны)…');
  ConParts conParts17 = ConParts(
      guns: Guns(
          name: 'К реактивным системам залпового огня',
          kig: 0.8,
          inBrigade: null,
          inParts: null),
      name: 'Отдельные мотострелковые и механизированные бригады (батальоны)…');
  ConParts conParts18 = ConParts(
      guns: Guns(
          name: 'К противотанковым ракетным комплексам',
          kig: 0.6,
          inBrigade: null,
          inParts: 1.15),
      name: 'Отдельные мотострелковые и механизированные бригады (батальоны)…');
  ConParts conParts19 = ConParts(
      guns: Guns(
          name:
              'К танкам, самоходным установкам, боевым машинам пехоты и бронетранспортерам',
          kig: 0.6,
          inBrigade: null,
          inParts: 2),
      name: 'Отдельные мотострелковые и механизированные бригады (батальоны)…');
  ConParts conParts20 = ConParts(
      guns: Guns(
          name: 'К зенитному вооружению', kig: 1, inBrigade: null, inParts: 2),
      name: 'Отдельные мотострелковые и механизированные бригады (батальоны)…');
  ConParts conParts21 = ConParts(
      guns: Guns(
          name:
              'К стрелковому оружию, гранатометам, ручные и реактивные гранаты',
          kig: 1,
          inBrigade: null,
          inParts: 1.25),
      name: 'Отдельные мотострелковые и механизированные бригады (батальоны)…');
  late List<ConParts> allConParts;
  AllGuns() {
    allConParts = [
      conParts1,
      conParts2,
      conParts3,
      conParts4,
      conParts5,
      conParts6,
      conParts7,
      conParts8,
      conParts9,
      conParts10,
      conParts11,
      conParts12,
      conParts13,
    ];
  }
}
