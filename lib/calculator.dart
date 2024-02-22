import 'package:disability_calculator/Rates.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisabilityCalculator extends StatefulWidget {
  const DisabilityCalculator({super.key});

  @override
  State<DisabilityCalculator> createState() => _DisabilityCalculatorState();
}

enum Percentages {
  ten,
  twenty,
  thirty,
  forty,
  fifty,
  sixty,
  seventy,
  eighty,
  ninety,
  hundred
}

enum MartialStatus { single, married }

enum Disability { LEFTLEG, RIGHTLEG, LEFTARM, RIGHTARM, Other }

enum DependentParents { None, One, Two }

enum AidAndAttendance { Yes, No }

final List<(AidAndAttendance, String)> aidAndAttendanceOptions = [
  (AidAndAttendance.Yes, 'Yes'),
  (AidAndAttendance.No, 'No'),
];

final List<(DependentParents, String)> dependentParentsOptions = [
  (DependentParents.None, 'None'),
  (DependentParents.One, 'One'),
  (DependentParents.Two, 'Two'),
];

final List<(MartialStatus, String)> martialStatusOptions = [
  (MartialStatus.single, 'Single'),
  (MartialStatus.married, 'Married'),
];

final List<(Disability, String)> disabilityOptions = [
  (Disability.LEFTLEG, 'Left Leg'),
  (Disability.RIGHTLEG, 'Right Leg'),
  (Disability.LEFTARM, 'Left Arm'),
  (Disability.RIGHTARM, 'Right Arm'),
  (Disability.Other, 'Other'),
];

final Map<Percentages, String> percentagesOptions = {
  Percentages.ten: '10',
  Percentages.twenty: '20',
  Percentages.thirty: '30',
  Percentages.forty: '40',
  Percentages.fifty: '50',
  Percentages.sixty: '60',
  Percentages.seventy: '70',
  Percentages.eighty: '80',
  Percentages.ninety: '90',
  Percentages.hundred: '100',
};

final Map<Disability, String> disabilityAbbreviations = {
  Disability.LEFTLEG: 'LL',
  Disability.RIGHTLEG: 'RL',
  Disability.LEFTARM: 'LA',
  Disability.RIGHTARM: 'RA',
  Disability.Other: 'O',
};

class _DisabilityCalculatorState extends State<DisabilityCalculator> {
  final List<bool> _percentagesSelections =
      List<bool>.filled(percentagesOptions.length, false);

  Map<Disability, Set<Percentages>> _disabilityPercentages = {};
  Set<MartialStatus> _martialStatusOptions = Set<MartialStatus>();
  Set<DependentParents> _dependentParentsOptions = Set<DependentParents>();
  Set<AidAndAttendance> _aidAndAttendanceOptions = Set<AidAndAttendance>();

  final List<String> _childrenBelow = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  final List<String> _childrenBetween = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  String _selectedChildrenBelow = '0';
  String _selectedChildrenBetween = '0';

  List<int> percentages = [];
  int numberOfChildrenBelow18 = 0;
  int numberOfChildrenBetween18And24 = 0;
  bool isMarried = false;
  bool needsAidAndAttendance = false;
  int numberOfDependentParents = 0;

  List<String> getSelectedPercentages() {
    List<String> selectedPercentages = [];
    for (int i = 0; i < _percentagesSelections.length; i++) {
      if (_percentagesSelections[i]) {
        Percentages key = Percentages.values[i];
        String percentage = percentagesOptions[key]!;
        selectedPercentages.add(percentage);
      }
    }
    return selectedPercentages;
  }

  // Widget to display selected percentages
  Widget selectedDisabilitiesWidget() {
    List<Widget> chips = [];
    _disabilityPercentages.forEach((disability, percentages) {
      for (var percentage in percentages) {
        String disabilityText =
            disabilityAbbreviations[disability] ?? 'Unknown';
        String percentageText = percentagesOptions[percentage] ?? 'Unknown';
        chips.add(Chip(
          label: Text('$disabilityText $percentageText%'),
          onDeleted: () {
            setState(() {
              percentages.remove(percentage);
              if (percentages.isEmpty) {
                _disabilityPercentages.remove(disability);
                this.percentages.remove(int.parse(percentageText));
              }
            });
          },
        ));
      }
    });

    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: chips,
    );
  }

  int getCombinedPercentages() {
    return Rates.calculateCombinedDisability(percentages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C75BC),
        title: Text('Disability Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            // Your fixed content here
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Combined Disability Rating is:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${getCombinedPercentages()}%',
                  style: TextStyle(fontSize: 48),
                ),
                Text(
                  'Your Total Amount is:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '\$${Rates.calculateTotalAmount(getCombinedPercentages(), numberOfChildrenBelow18, numberOfChildrenBetween18And24, isMarried, needsAidAndAttendance, numberOfDependentParents)}',
                  style: TextStyle(fontSize: 48),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(),
                    )),
                    Text("STEP 1",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff1C75BC))),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(),
                    )),
                  ]),
                  Text('Select Disabilities and Percentages:',
                      style: TextStyle(fontSize: 16)),
                  ...disabilityOptions.map((option) {
                    return ListTile(
                      title: Text(option.$2),
                      trailing: PopupMenuButton<Percentages>(
                        onSelected: (Percentages percentage) {
                          setState(() {
                            if (!_disabilityPercentages
                                .containsKey(option.$1)) {
                              _disabilityPercentages[option.$1] = {};
                            }
                            _disabilityPercentages[option.$1]?.add(percentage);
                            percentages.add(
                                int.parse(percentagesOptions[percentage]!));
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return Percentages.values
                              .map((Percentages percentage) {
                            return PopupMenuItem<Percentages>(
                              value: percentage,
                              child: Text(
                                  percentagesOptions[percentage] ?? 'Unknown'),
                            );
                          }).toList();
                        },
                      ),
                    );
                  }).toList(), // Spacing between elements
                  selectedDisabilitiesWidget(),
                  SizedBox(height: 20), // Spacing between elements
                  Row(children: <Widget>[
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(),
                    )),
                    Text("STEP 2",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff1C75BC))),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(),
                    )),
                  ]),
                  SizedBox(height: 20), // Spacing between elements
                  Text(
                      'How many dependent children do you have who are under the age of 18?',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10), // Spacing between elements
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    // Optional, for inner padding
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff1C75BC), width: 1),
                      // Customize border color and width
                      borderRadius: BorderRadius.circular(
                          15), // Optional, for rounded corners
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        //remove underline
                        underline: SizedBox(),
                        items: _childrenBelow.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        elevation: 16,
                        icon: const Icon(Icons.arrow_downward),
                        value: _selectedChildrenBelow,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedChildrenBelow = value!;
                            numberOfChildrenBelow18 = int.parse(value);
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'How many dependent children do you have who are between the ages of 18 and 24?',
                    style: TextStyle(fontSize: 14),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    // Optional, for inner padding
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff1C75BC), width: 1),
                      // Customize border color and width
                      borderRadius: BorderRadius.circular(
                          15), // Optional, for rounded corners
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        //remove underline
                        underline: SizedBox(),
                        items:
                            _childrenBetween.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        elevation: 16,
                        icon: const Icon(Icons.arrow_downward),
                        value: _selectedChildrenBetween,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedChildrenBetween = value!;
                            numberOfChildrenBetween18And24 = int.parse(value);
                          });
                        }),
                  ),
                  SizedBox(height: 20), // Spacing between elements
                  Text('What is your marital status?',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10), // Spacing between elements
                  Container(
                    width: double.infinity,
                    child: SegmentedButton(
                      multiSelectionEnabled: false,
                      emptySelectionAllowed: true,
                      selected: _martialStatusOptions,
                      onSelectionChanged: (Set<MartialStatus> newSelection) {
                        setState(() {
                          _martialStatusOptions = newSelection;
                          isMarried = _martialStatusOptions
                              .contains(MartialStatus.married);
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(100, 45)),
                      ),
                      segments: martialStatusOptions.map((option) {
                        return ButtonSegment(
                          value: option.$1,
                          label: Text(option.$2),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20), // Spacing between elements
                  if (_martialStatusOptions
                      .contains(MartialStatus.married)) ...[
                    Text('Do you need aid and attendance?',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10), // Spacing between elements
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton(
                        multiSelectionEnabled: false,
                        emptySelectionAllowed: true,
                        selected: _aidAndAttendanceOptions,
                        onSelectionChanged:
                            (Set<AidAndAttendance> newSelection) {
                          setState(() {
                            _aidAndAttendanceOptions = newSelection;
                            needsAidAndAttendance = _aidAndAttendanceOptions
                                .contains(AidAndAttendance.Yes);
                          });
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          minimumSize: MaterialStateProperty.all(Size(100, 45)),
                        ),
                        segments: aidAndAttendanceOptions.map((option) {
                          return ButtonSegment(
                            value: option.$1,
                            label: Text(option.$2),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                  Text('How many dependent parents do you have?',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10), // Spacing between elements
                  Container(
                    width: double.infinity,
                    child: SegmentedButton(
                      multiSelectionEnabled: false,
                      emptySelectionAllowed: true,
                      selected: _dependentParentsOptions,
                      onSelectionChanged: (Set<DependentParents> newSelection) {
                        setState(() {
                          _dependentParentsOptions = newSelection;
                          if (_dependentParentsOptions
                              .contains(DependentParents.None)) {
                            numberOfDependentParents = 0;
                          } else if (_dependentParentsOptions
                              .contains(DependentParents.One)) {
                            numberOfDependentParents = 1;
                          } else if (_dependentParentsOptions
                              .contains(DependentParents.Two)) {
                            numberOfDependentParents = 2;
                          }
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(100, 45)),
                      ),
                      segments: dependentParentsOptions.map((option) {
                        return ButtonSegment(
                          value: option.$1,
                          label: Text(option.$2),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text('Schedule a consult with us',
                          style: TextStyle(fontSize: 16)),
                      TextButton(
                          isSemanticButton: true,
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'https://bevetstrong.com/contact-us/');
                            if (!await launchUrl(url)) {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'HERE!',
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
