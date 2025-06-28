import 'package:get/get.dart';

class LeaderboardUser {
  final String name;
  final int points;
  final String avatar;
  final bool isCurrentUser;

  LeaderboardUser({
    required this.name,
    required this.points,
    required this.avatar,
    this.isCurrentUser = false,
  });
}

class LeaderboardsController extends GetxController {
  final selectedTab = 'Global'.obs;
  final leaderboard = <LeaderboardUser>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Mock data - replace with actual API call
    loadLeaderboard('Global');
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
    loadLeaderboard(tab);
  }

  void loadLeaderboard(String tab) {
    // Mock data - replace with actual API call
    leaderboard.value = [
      LeaderboardUser(name: 'Marsha Fisher', points: 60, avatar: 'assets/avatar2.png'),
      LeaderboardUser(name: 'Brian J. Little', points: 40, avatar: 'assets/avatar1.png'),
      LeaderboardUser(name: 'Robert K. Cohn', points: 39, avatar: 'assets/avatar3.png'),
      LeaderboardUser(name: 'James C. Woods', points: 36, avatar: 'assets/avatar4.png'),
      LeaderboardUser(name: 'Walter M. Bartlett', points: 35, avatar: 'assets/avatar5.png', isCurrentUser: true), // Current user
      LeaderboardUser(name: 'Gilbert C. Connery', points: 34, avatar: 'assets/avatar6.png'),
      LeaderboardUser(name: 'Meghan E. Lesse', points: 33, avatar: 'assets/avatar7.png'),
      LeaderboardUser(name: 'Cynthia C. Huffman', points: 32, avatar: 'assets/avatar8.png'),
    ];
  }
}