class ReminderItem {
  final String id;
  final String timePeriod;
  final String title;
  final bool isSeen;
  final String category;
  final String description;
  final String? timestamp;

  ReminderItem( {
    required this.isSeen,
    String? id,
    required this.timePeriod,
    required this.title,
    required this.category,
    required this.description,
    this.timestamp,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ReminderItem &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ReminderData {
  static List<ReminderItem> get sampleData => [
    // Today's reminders
    ReminderItem(
      timePeriod: "Today",
      isSeen :true,
      title: "Mom's Birthday",
      timestamp:"1d 10 min",

      category: "Birthdays",
      description:
      "Don't miss their special day—send love, wishes, and joy that make birthdays truly unforgettable!",
    ),
    ReminderItem(
      timePeriod: "Today",
      title: "Anniversary Reminder",
      timestamp:"1d 10 min",
      category: "Anniversary",
      description: "Plan a special surprise with her.", isSeen: true,
    ),
    ReminderItem(
      timePeriod: "Today",
      title: "Project Launch",
      timestamp:"1d 10 min",
      category: "Spark",
      description: "Send congrats to the team.",
      isSeen: false,
    ),

    // Yesterday's reminders
    ReminderItem(
      isSeen: true,
      timePeriod: "Yesterday",
      title: "Dads Retirement",
      timestamp:"1d 10 min",
      category: "Spark",
      description: "Plan a thoughtful gift and note.",
    ),
    ReminderItem(
      isSeen: true,
      timePeriod: "Yesterday",
      timestamp:"1d 10 min",
      title: "Mindful Break",
      category: "Self-Care",
      description: "5 minutes of deep breathing",
    ),
    ReminderItem(
      isSeen: true,
      timePeriod: "Yesterday",
      title: "Drink Water",
      category: "Self-Care",
      timestamp: "9min ago",
      description:
      "Pause, breathe, and give yourself time—because self-care today builds a stronger, calmer tomorrow.",
    ),

    // Recent reminder with timestamp
    ReminderItem(
      isSeen: false,
      timePeriod: "Yesterday",
      title: "",
      category: "",
      description: "",
      timestamp: "9min ago",
    ),
  ];

  static Map<String, List<ReminderItem>> getGroupedReminders() {
    final Map<String, List<ReminderItem>> grouped = {};
    for (final reminder in sampleData) {
      grouped.putIfAbsent(reminder.timePeriod, () => []).add(reminder);
    }
    return grouped;
  }

  static List<String> getTimePeriods() {
    final periods = sampleData.map((e) => e.timePeriod).toSet().toList();
    periods.sort((a, b) {
      const order = ["Today", "Yesterday", ];
      final indexA = order.indexOf(a);
      final indexB = order.indexOf(b);
      return indexA.compareTo(indexB);
    });
    return periods;
  }
}