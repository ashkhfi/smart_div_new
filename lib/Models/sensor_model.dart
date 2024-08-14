class sensorModel {
  double iBaterai;
  String iInverter;
  String iPln;
  String iPlts;
  String irsPltb;
  String istPltb;
  String itrPltb;
  String modeAktif;
  String socBaterai;
  String vBaterai;
  String vInverter;
  String vPln;
  String vPlts;
  String vrsPltb;
  String vstPltb;
  String vtrPltb;

  sensorModel({
    required this.iBaterai,
    required this.iInverter,
    required this.iPln,
    required this.iPlts,
    required this.irsPltb,
    required this.istPltb,
    required this.itrPltb,
    required this.modeAktif,
    required this.socBaterai,
    required this.vBaterai,
    required this.vInverter,
    required this.vPln,
    required this.vPlts,
    required this.vrsPltb,
    required this.vstPltb,
    required this.vtrPltb,
  });

  // Method to create a sensorModel instance from a JSON map
  factory sensorModel.fromJson(Map<String, dynamic> json) {
    return sensorModel(
      iBaterai: json['i_baterai'],
      iInverter: json['i_inverter'],
      iPln: json['i_pln'],
      iPlts: json['i_plts'],
      irsPltb: json['irs_pltb'],
      istPltb: json['ist_pltb'],
      itrPltb: json['itr_pltb'],
      modeAktif: json['mode_aktif'],
      socBaterai: json['soc_baterai'],
      vBaterai: json['v_baterai'],
      vInverter: json['v_inverter'],
      vPln: json['v_pln'],
      vPlts: json['v_plts'],
      vrsPltb: json['vrs_pltb'],
      vstPltb: json['vst_pltb'],
      vtrPltb: json['vtr_pltb'],
    );
  }

  // Method to convert a sensorModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'i_baterai': iBaterai,
      'i_inverter': iInverter,
      'i_pln': iPln,
      'i_plts': iPlts,
      'irs_pltb': irsPltb,
      'ist_pltb': istPltb,
      'itr_pltb': itrPltb,
      'mode_aktif': modeAktif,
      'soc_baterai': socBaterai,
      'v_baterai': vBaterai,
      'v_inverter': vInverter,
      'v_pln': vPln,
      'v_plts': vPlts,
      'vrs_pltb': vrsPltb,
      'vst_pltb': vstPltb,
      'vtr_pltb': vtrPltb,
    };
  }
}
