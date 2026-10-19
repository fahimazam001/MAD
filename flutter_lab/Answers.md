Name: Fahim Azam
Roll No: 04072312039

A1: 39
A2: 9
A3: 20
A4: 5

B1: 
- Stateless Classes: LabApp, HomePage, StudentCard, GoalBanner. They are stateless because their visual output depends entirely on their initial immutable configuration parameters and they do not change over time internally.
- Stateful Classes: Tally, BuggyCounter, Countdown. They are stateful because they manage internal mutable data (_count, _clicks, _left) that changes in response to user actions or timer ticks.

B2: 
The Timer must be cancelled in dispose() to stop active background callbacks from executing after the widget is removed from the widget tree. If left uncancelled, it can cause memory leaks and runtime exceptions like "setState() called after dispose()".

B3: 
Widgets like LabApp, HomePage, StudentCard, GoalBanner, Tally, BuggyCounter, and Countdown (along with constant UI elements like SizedBox and Text styles) can be const. Using const improves app performance by allowing Flutter to cache and reuse widget instances instead of rebuilding them unnecessarily.