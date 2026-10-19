// main.dart - Study Tracker lab

// Step 1 Think Answer:
// - runApp receives the root widget of the entire application (e.g., LabApp), 
//   which sets up the app framework and core app-level configurations.
// - MaterialApp receives as 'home' the default/initial screen route (e.g., HomePage) 
//   that is displayed to the user when the app first launches.

// Step 2 Think Answer:
// - Why are the fields of a StatelessWidget final? 
//   Because a StatelessWidget is immutable (unchangeable) once created; its configuration cannot change over time.
// - What would the compiler say if you removed final? 
//   The compiler would throw an error stating that mutable fields are not allowed in an immutable widget class.

// Step 3 Think Answer:
// - Widget tree levels down to Text('Max: ..'):
//   1. LabApp -> 2. MaterialApp -> 3. HomePage -> 4. Scaffold 
//   -> 5. SingleChildScrollView -> 6. Column -> 7. Row -> 8. Text('Max: ...')
//   Total depth: 8 levels from the root.

// Step 4 Think Answer:
// - Why does GoalBanner not need setState? 
//   Because GoalBanner is a StatelessWidget; it is immutable and purely a reflection of its given input properties (count and max).
// - What would you have to do to make it show a new count? 
//   Its parent widget must be rebuilt with a new `count` value passed into GoalBanner's constructor.

// Step 5 Think Answer:
// - The class Tally has no fields that change, yet _TallyState does. Why are there two classes? 
//   Because widgets are immutable configuration blueprints that get recreated frequently as the UI updates, 
//   while the State object persists across these rebuilds to remember and manage the mutable data.

import 'package:flutter/material.dart';

const String studentName = 'Fahim Azam';
const String rollNo = '04072312039'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev', 'Data Structures', 'Operating Systems', 'Databases',
  'Networks', 'Software Eng', 'AI', 'Web Engineering', 'Graphics', 'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Study Tracker',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Tracker: $course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentCard(
              name: studentName,
              roll: rollNo,
              course: course,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('info-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),
            const Tally(),
          ],
        ),
      ),
    );
  }
}

// Step 2: StudentCard widget implementation
class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  final String name;
  final String roll;
  final String course;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}

// Step 4: GoalBanner widget implementation
class GoalBanner extends StatelessWidget {
  const GoalBanner({
    super.key,
    required this.count,
    required this.max,
  });

  final int count;
  final int max;

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;
    return Text('Progress: $count of $max ($percent%)', key: const Key('progress'));
  }
}

// Step 5: Tally StatefulWidget implementation
class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  int _count = startCount;

  void _plus() {
    setState(() {
      _count += stepSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        const SizedBox(height: 8),
        GoalBanner(count: _count, max: maxCount),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
          ],
        ),
      ],
    );
  }
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            _clicks += bugStep;
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}