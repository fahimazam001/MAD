// main.dart - Team Board lab

import 'dart:async';
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
const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];
const List<String> mains = [
  'start', 'center', 'end', 'spaceBetween', 'spaceAround', 'spaceEvenly',
];
const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];
const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5); // where the clock starts
final int tick = 1 + u % 3; // how much it adds every second
final int ticks = 4 + u % 4; // how many ticks until it stops
final int stopAt = startSec + ticks * tick; // the clock stops here

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3; // used by the experiment in Step 5

// Step 6: axes (the NAMES are printed on the settings card; you type the enum)
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5]; // use swatches[hue]!.shade100

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SettingsCard(),
            SizedBox(height: 12),
            Welcome(),
            SizedBox(height: 12),
            Clock(),
            SizedBox(height: 12),
            SwapBoard(),
            SizedBox(height: 12),
            InfoPanel(),
            SizedBox(height: 12),
            SummaryRow(),
            SizedBox(height: 12),
            ShareRow(),
            SizedBox(height: 12),
            InfoBox(),
            SizedBox(height: 12),
            StampStack(),
          ],
        ),
      ),
    );
  }
}

// ---- Provided: shows YOUR numbers. Keep it on the page. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

// ==========================================
// Step 10: StampStack Widget
// ==========================================
class StampStack extends StatelessWidget {
  const StampStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('stack'),
      children: [
        Container(
          key: const Key('layer-base'),
          width: 300,
          height: 120,
          color: Colors.grey.shade300,
        ),
        Positioned(
          top: dotTop,
          right: dotRight,
          child: const Icon(Icons.star, key: Key('dot-top')),
        ),
        Positioned(
          bottom: dotBottom,
          left: dotLeft,
          child: const Icon(Icons.circle, key: Key('dot-bottom')),
        ),
      ],
    );
  }
}

// ==========================================
// Step 9: InfoBox Widget
// ==========================================
class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('info-box'),
      margin: EdgeInsets.all(boxMargin),
      padding: EdgeInsets.all(boxPad),
      decoration: BoxDecoration(
        color: swatches[hue]!.shade100,
        borderRadius: BorderRadius.circular(boxRadius),
        border: Border.all(width: boxBorder),
      ),
      child: Text('Course: $course', key: const Key('box-text')),
    );
  }
}

// ==========================================
// Step 8: ShareRow Widget
// ==========================================
class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('share-row'),
      children: [
        SizedBox(
          key: const Key('fixed'),
          width: fixedW,
          child: ElevatedButton(onPressed: () {}, child: const Text('F')),
        ),
        Expanded(
          flex: flexA,
          child: ElevatedButton(
            key: const Key('exp'),
            onPressed: () {},
            child: const Text('Exp'),
          ),
        ),
        Flexible(
          flex: flexB,
          child: ElevatedButton(
            key: const Key('flex'),
            onPressed: () {},
            child: const Text('Flex'),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// Step 7: SummaryRow Widget
// ==========================================
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// Step 1 & 2 & 3: The Clock, Lifecycle, & Probe
// ==========================================
class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0; // Track number of builds

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState'); // Log initState

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);
      if (_seconds >= stopAt) timer.cancel(); // stop at your limit
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the active timer
    lifecycleLog.add('dispose'); // Log dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++; // Increment build counter on every build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        const SizedBox(height: 4),
        Text('Builds: $_builds', key: const Key('builds')),
        const SizedBox(height: 4),
        const Probe(seconds: 5), // placeholder/updated safely if needed
      ],
    );
  }
}

// ==========================================
// Step 3: Probe Widget
// ==========================================
class Probe extends StatelessWidget {
  final int seconds;
  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final bool above = context.findAncestorWidgetOfExactType<Scaffold>() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at: $seconds s', key: const Key('probe-seen')),
        Text('Widget #${identityHashCode(this)}', key: const Key('probe-widget')),
        Text('Element #${identityHashCode(context)}', key: const Key('probe-element')),
        Text('Context belongs to: ${context.widget.runtimeType}', key: const Key('probe-context')),
        Text('Scaffold above me: $above', key: const Key('probe-above')),
      ],
    );
  }
}

// ==========================================
// Step 4: Welcome & Tile Widgets
// ==========================================
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome, $studentName',
        key: const Key('welcome'),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  final String label;
  const Tile(this.label, {super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => taps++),
      child: Text('${widget.label}: $taps'),
    );
  }
}

// ==========================================
// Step 5: SwapBoard Widget
// ==========================================
class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  late List<Widget> tiles = [
    Tile(tileA, key: ValueKey(tileA)),
    Tile(tileB, key: ValueKey(tileB)),
    Tile(tileC, key: ValueKey(tileC)),
  ];

  void swap() => setState(() => tiles = tiles.reversed.toList());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            tiles[0],
            const SizedBox(width: 8),
            tiles[1],
            const SizedBox(width: 8),
            tiles[2],
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

// ==========================================
// Step 6: InfoPanel Widget
// ==========================================
class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment getRowMainAxis(String name) {
      switch (name) {
        case 'center':
          return MainAxisAlignment.center;
        case 'end':
          return MainAxisAlignment.end;
        case 'spaceBetween':
          return MainAxisAlignment.spaceBetween;
        case 'spaceAround':
          return MainAxisAlignment.spaceAround;
        case 'spaceEvenly':
          return MainAxisAlignment.spaceEvenly;
        case 'start':
        default:
          return MainAxisAlignment.start;
      }
    }

    CrossAxisAlignment getColumnCrossAxis(String name) {
      switch (name) {
        case 'center':
          return CrossAxisAlignment.center;
        case 'end':
          return CrossAxisAlignment.end;
        case 'start':
        default:
          return CrossAxisAlignment.start;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: getRowMainAxis(mainName),
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: getColumnCrossAxis(crossName),
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}

/*
  Think Question Answers 10:
  - What decides the size of the Stack?
    By default, a non-positioned `Stack` sizes itself to fit its **non-positioned** children (in this case, the base grey `Container`). Positioned children do not contribute to sizing the Stack.
  - What happens to the layout if the Icons come first and the grey Container last?
    If the grey `Container` comes last, it will be painted on top of the icons (as the top layer of the stack), completely obscuring the star and circle icons underneath it.
*/

/*
  Think Question Answer 9:
  - Which one is inside the border, margin or padding?
    **Padding** is inside the border (between the border and the child widget content), whereas **margin** is outside the border (spacing the container away from neighboring widgets).
  - When would you use a plain Padding or SizedBox instead of a Container?
    You would use a plain `Padding` widget when you only need inner spacing and want a lighter-weight widget. You would use a `SizedBox` when you specifically need to force a fixed width or height, or create simple empty spacing without extra decoration or margin overhead.
*/
/*
  Think Question Answer 8:
  - What would change on the screen if you swapped Expanded and Flexible between the two buttons? Which one is “Flexible with fit: tight”?
    If you swapped them, the button wrapped in `Expanded` would keep its natural small size while the one in `Flexible` would stretch to fill its allocated space. `Expanded` is essentially just a `Flexible` widget with `fit: FlexFit.tight`.
*/

/*
  Think Question Answer 7:
  - Why does wrapping a Text in Expanded make it wrap its words? Use the idea “constraints go down, sizes go up”.
    Following the rule that "constraints go down, sizes go up", an unconstrained Row gives its children infinite horizontal space to grow, causing text to overflow off-screen. When you wrap a `Text` in `Expanded`, the `Row` passes tight or bounded maximum width constraints down to the `Expanded` widget, which forces the `Text` to respect that maximum width boundary and wrap its text content across multiple lines.
*/

/*
  Think Question Answer 6:
  - In a Column, which axis is the main axis? Why does crossAxisAlignment: CrossAxisAlignment.center in a Column move the children left or right and not up or down?
    In a Column, the main axis is the **vertical axis** (top-to-bottom). Therefore, the cross axis is the **horizontal axis** (left-to-right). Setting `crossAxisAlignment: CrossAxisAlignment.center` aligns children along the cross axis, which runs horizontally across the width of the screen, moving them left or right rather than up or down.
*/

/*
  Think Question Answer 5:
  - Without keys, why did the number stay at the left even though the label moved?
    Without keys, Flutter matches new widgets to existing elements based strictly on their **position** in the tree 
    rather than their identity. When the list is reversed, the Element at position index 0 reuses the existing State object 
    (which holds the accumulated tap count), but receives the new Widget with the new label. Therefore, the tap count 
    remains pinned to the position on the left, while only the visual text label changes.
*/

/*
  Think Question Answer 4:
  - You built Tile out of an ElevatedButton without writing extends ElevatedButton. What is this style called, and why does Flutter prefer it?
    This style is called **Composition over Inheritance**. Flutter prefers composition because 
    creating a deep custom subclass for every small visual change or behavior leads to rigid hierarchies, 
    whereas composition allows you to assemble simple, reusable building blocks flexibly and maintainably.
*/
/*
  Think Question Answers 3:
  - Which of the two, Widget or Element, is “cheap and thrown away” and which one keeps the State?
    The Widget is cheap and thrown away (recreated on every build), whereas the Element stays 
    persistent in the element tree. The State object is associated with the Element and is also 
    preserved across widget rebuilds.
  - Where is the third one, the RenderObject, and what is its job?
    The RenderObject sits behind the Element in the RenderTree. Its job is to handle the actual 
    layout, painting, and hit-testing on the screen (computing sizes and positioning pixels).
*/

/*
  Think Question Answers 2:
  - Why does Builds go up by one per second and not by two?
    The `setState()` call inside the Timer callback triggers a single rebuild for the StatefulWidget 
    per second. Even though `_seconds` increases by `tick` (which might be greater than 1), `setState()` 
    is only called once per second, resulting in exactly one build per second.
  - What error would you see in the console if the widget left the screen and _timer.cancel() was missing from dispose?
    You would see a Flutter error related to calling `setState()` on a deactivated or unmounted widget 
    (e.g., "setState() called after dispose()"), because the periodic timer would continue trying to fire 
    and call `setState()` on a widget that no longer exists in the widget tree.
*/

/*
  Think Question Answer 1:
  - Why do we start the Timer in initState and not inside build?
    initState() is called exactly once when the State object is inserted into the widget tree. 
    Starting the Timer here ensures it is initialized precisely once.
  - What would happen to the speed of the clock if we started it in build?
    If we started it inside build(), a new periodic timer would be created every single time 
    the widget rebuilds (such as on every `setState()` tick). This would spawn multiple concurrent 
    timers, causing memory leaks and making the clock tick exponentially faster and out of control.
*/