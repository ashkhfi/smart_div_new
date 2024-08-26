class sensorModel {
  final String commandAndroid;
  final String iBaterai;
  final String iInverter;
  final String iPln;
  final String iPlts;
  final String irsPltb;
  final String istPltb;
  final String itrPltb;
  final String mode;
  final String plnUsage;
  final String reUsage;
  final String socBaterai;
  final String sumber;
  final String vBaterai;
  final String vInverter;
  final String vPln;
  final String vPlts;
  final String vrsPltb;
  final String vstPltb;
  final String vtrPltb;

  sensorModel({
    required this.commandAndroid,
    required this.iBaterai,
    required this.iInverter,
    required this.iPln,
    required this.iPlts,
    required this.irsPltb,
    required this.istPltb,
    required this.itrPltb,
    required this.mode,
    required this.plnUsage,
    required this.reUsage,
    required this.socBaterai,
    required this.sumber,
    required this.vBaterai,
    required this.vInverter,
    required this.vPln,
    required this.vPlts,
    required this.vrsPltb,
    required this.vstPltb,
    required this.vtrPltb,
  });

  factory sensorModel.fromJson(Map<String, dynamic> json) {
    return sensorModel(
      commandAndroid: json['commandAndroid'],
      iBaterai: json['i_baterai'],
      iInverter: json['i_inverter'],
      iPln: json['i_pln'],
      iPlts: json['i_plts'],
      irsPltb: json['irs_pltb'],
      istPltb: json['ist_pltb'],
      itrPltb: json['itr_pltb'],
      mode: json['mode'],
      plnUsage: json['pln_usage'],
      reUsage: json['re_usage'],
      socBaterai: json['soc_baterai'],
      sumber: json['sumber'],
      vBaterai: json['v_baterai'],
      vInverter: json['v_inverter'],
      vPln: json['v_pln'],
      vPlts: json['v_plts'],
      vrsPltb: json['vrs_pltb'],
      vstPltb: json['vst_pltb'],
      vtrPltb: json['vtr_pltb'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commandAndroid': commandAndroid,
      'i_baterai': iBaterai,
      'i_inverter': iInverter,
      'i_pln': iPln,
      'i_plts': iPlts,
      'irs_pltb': irsPltb,
      'ist_pltb': istPltb,
      'itr_pltb': itrPltb,
      'mode': mode,
      'pln_usage': plnUsage,
      're_usage': reUsage,
      'soc_baterai': socBaterai,
      'sumber': sumber,
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
