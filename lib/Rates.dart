import 'dart:collection';

class Rates {
  static final Map<String, double> rates10Percent = {
    "Pay Veteran alone": 171.23
  };
  static final Map<String, double> rates20Percent = {
    "Pay Veteran alone": 338.49
  };
  static final Map<String, double> rates30Percent = {
    'Pay Veteran alone': 524.31,
    'Spouse': 583.31,
    'Spouse/1 parent/no child': 636.31,
    'Spouse/2 parent/no child': 686.31,
    '1 parent': 571.31,
    '2 parent': 624.31,
    'kid': 565.31,
    'kid/spouse': 632.31,
    'kid/spouse/1 par': 682.31,
    'kid/spouse/2 par': 732.31,
    'kid/1 par': 615.31,
    'kid/2 par': 665.31,
    'Spouse A&A': 57.00,
    'Each add kid <18': 31.00,
    'Each add kid over 18': 100.00,
  };
  static final Map<String, double> rates40Percent = {
    'Pay Veteran alone': 755.28,
    'Spouse': 838.28,
    'Spouse/1 parent/no child': 904.28,
    'Spouse/2 parent/no child': 970.28,
    '1 parent': 821.28,
    '2 parent': 887.28,
    'kid': 810.28,
    'kid/spouse': 899.28,
    'kid/spouse/1 par': 965.28,
    'kid/spouse/2 par': 1031.28,
    'kid/1 par': 876.28,
    'kid/2 par': 942.28,
    'Spouse A&A': 76.00,
    'Each add kid <18': 41.00,
    'Each add kid over 18': 133.00,
  };

  static final Map<String, double> rates50Percent = {
    'Pay Veteran alone': 1075.16,
    'Spouse': 1179.16,
    'Spouse/1 parent/no child': 1262.16,
    'Spouse/2 parent/no child': 1345.16,
    '1 parent': 1158.16,
    '2 parent': 1241.16,
    'kid': 1144.16,
    'kid/spouse': 1255.16,
    'kid/spouse/1 par': 1338.16,
    'kid/spouse/2 par': 1421.16,
    'kid/1 par': 1227.16,
    'kid/2 par': 1310.16,
    'Spouse A&A': 95.00,
    'Each add kid <18': 51.00,
    'Each add kid over 18': 167.00,
  };

  static final Map<String, double> rates60Percent = {
    'Pay Veteran alone': 1361.88,
    'Spouse': 1486.88,
    'Spouse/1 parent/no child': 1586.88,
    'Spouse/2 parent/no child': 1686.88,
    '1 parent': 1461.88,
    '2 parent': 1561.88,
    'kid': 1444.88,
    'kid/spouse': 1577.88,
    'kid/spouse/1 par': 1677.88,
    'kid/spouse/2 par': 1777.88,
    'kid/1 par': 1544.88,
    'kid/2 par': 1644.88,
    'Spouse A&A': 114.00,
    'Each add kid <18': 62.00,
    'Each add kid over 18': 200.00,
  };

  static final Map<String, double> rates70Percent = {
    'Pay Veteran alone': 1716.28,
    'Spouse': 1861.28,
    'Spouse/1 parent/no child': 1978.28,
    'Spouse/2 parent/no child': 2095.28,
    '1 parent': 1833.28,
    '2 parent': 1950.28,
    'kid': 1813.28,
    'kid/spouse': 1968.28,
    'kid/spouse/1 par': 2085.28,
    'kid/spouse/2 par': 2202.28,
    'kid/1 par': 1930.28,
    'kid/2 par': 2047.28,
    'Spouse A&A': 134.00,
    'Each add kid <18': 72.00,
    'Each add kid over 18': 234.00,
  };

  static final Map<String, double> rates80Percent = {
    'Pay Veteran alone': 1995.01,
    'Spouse': 2161.01,
    'Spouse/1 parent/no child': 2294.01,
    'Spouse/2 parent/no child': 2427.01,
    '1 parent': 2128.01,
    '2 parent': 2261.01,
    'kid': 2106.01,
    'kid/spouse': 2283.01,
    'kid/spouse/1 par': 2416.01,
    'kid/spouse/2 par': 2549.01,
    'kid/1 par': 2239.01,
    'kid/2 par': 2372.01,
    'Spouse A&A': 153.00,
    'Each add kid <18': 82.00,
    'Each add kid over 18': 267.00,
  };

  static final Map<String, double> rates90Percent = {
    'Pay Veteran alone': 2241.91,
    'Spouse': 2428.91,
    'Spouse/1 parent/no child': 2578.91,
    'Spouse/2 parent/no child': 2728.91,
    '1 parent': 2391.91,
    '2 parent': 2541.91,
    'kid': 2366.91,
    'kid/spouse': 2565.91,
    'kid/spouse/1 par': 2715.91,
    'kid/spouse/2 par': 2865.91,
    'kid/1 par': 2516.91,
    'kid/2 par': 2666.91,
    'Spouse A&A': 172.00,
    'Each add kid <18': 93.00,
    'Each add kid over 18': 301.00,
  };

  static final Map<String, double> rates100Percent = {
    'Pay Veteran alone': 3737.85,
    'Spouse': 3946.25,
    'Spouse/1 parent/no child': 4113.51,
    'Spouse/2 parent/no child': 4280.77,
    '1 parent': 3905.11,
    '2 parent': 4072.37,
    'kid': 3877.22,
    'kid/spouse': 4098.87,
    'kid/spouse/1 par': 4266.13,
    'kid/spouse/2 par': 4433.39,
    'kid/1 par': 4044.48,
    'kid/2 par': 4211.74,
    'Spouse A&A': 191.14,
    'Each add kid <18': 103.55,
    'Each add kid over 18': 334.49,
  };

  static Map<String, double> getRatesMap(int percent) {
    switch (percent) {
      case 10:
        return rates10Percent;
      case 20:
        return rates20Percent;
      case 30:
        return rates30Percent;
      case 40:
        return rates40Percent;
      case 50:
        return rates50Percent;
      case 60:
        return rates60Percent;
      case 70:
        return rates70Percent;
      case 80:
        return rates80Percent;
      case 90:
        return rates90Percent;
      case 100:
        return rates100Percent;
      default:
        return {};
    }
  }

  static int calculateCombinedDisability(List<int> percentages) {
    double cumulativeEffect = 1.0;
    for (int percentage in percentages) {
      cumulativeEffect *= (1.0 - (percentage / 100.0));
    }
    int combined = (100.0 * (1.0 - cumulativeEffect)).round();
    // VA rounds to the nearest 10
    return (combined / 10).round() * 10;
  }

  static double calculateTotalAmount(int percentage, int childrenBelow18,
      int childrenOver18, bool isMarried, bool spouseAA, int dependentParents) {
    var selectedRates = getRatesMap(percentage);
    double total = 0.0;

    if (percentage == 10 || percentage == 20) {
      return selectedRates["Pay Veteran alone"] ?? 0.0;
    }

    if(percentage > 20 && childrenBelow18 == 0 && childrenOver18 == 0 && !isMarried && dependentParents == 0) {
      return selectedRates["Pay Veteran alone"] ?? 0.0;
    }


    // Determine the base rate
    if (isMarried) {
      // Married scenarios
      if (dependentParents == 1) {
        total += (childrenBelow18 + childrenOver18 > 0)
            ? selectedRates["kid/spouse/1 par"] ?? 0.0
            : selectedRates["Spouse/1 parent/no child"] ?? 0.0;
      } else if (dependentParents == 2) {
        total += (childrenBelow18 + childrenOver18 > 0)
            ? selectedRates["kid/spouse/2 par"] ?? 0.0
            : selectedRates["Spouse/2 parent/no child"] ?? 0.0;
      } else {
        total += (childrenBelow18 + childrenOver18 > 0)
            ? selectedRates["kid/spouse"] ?? 0.0
            : selectedRates["Spouse"] ?? 0.0;
      }
      if (spouseAA) {
        total += selectedRates["Spouse A&A"] ?? 0.0;
      }
    } else {
      // Not married scenarios
      if (dependentParents == 1) {
        total += (childrenBelow18 + childrenOver18 > 0)
            ? selectedRates["kid/1 par"] ?? 0.0
            : selectedRates["1 parent"] ?? 0.0;
      } else if (dependentParents == 2) {
        total += (childrenBelow18 + childrenOver18 > 0)
            ? selectedRates["kid/2 par"] ?? 0.0
            : selectedRates["2 parent"] ?? 0.0;
      } else {
        total += selectedRates["kid"] ?? 0.0; // Single with one child
      }
    }

    // Adding for additional children if needed
    if (isMarried || dependentParents > 0) {
      total += ((childrenBelow18 - 1) > 0 ? (childrenBelow18 - 1) : 0) *
          (selectedRates["Each add kid <18"] ?? 0.0);
      total += childrenOver18 * (selectedRates["Each add kid over 18"] ?? 0.0);
    } else {
      total += (childrenBelow18 > 1 ? (childrenBelow18 - 1) : 0) *
          (selectedRates["Each add kid <18"] ?? 0.0);
      total += childrenOver18 * (selectedRates["Each add kid over 18"] ?? 0.0);
    }

    return total;
  }
}
