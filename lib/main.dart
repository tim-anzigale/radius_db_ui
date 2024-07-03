import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radius_db_ui/models/subscription_class.dart';
import './pages/home_screen.dart';
import './pages/subscriptions_page.dart';
import './pages/settings.dart';
import './pages/profile_page.dart';
import './pages/subscription_details_page.dart';
import './pages/users_page.dart';
import './pages/plans_page.dart';
import './pages/plan_details_page.dart';
import './pages/poles_page.dart';
import './pages/poles_path_page.dart';
import './pages/poles_main_page.dart';
import 'services/api_service.dart';
import 'services/datasync_service.dart';
import 'theme_provider.dart';
import './theme/theme_manager.dart';
import 'navigation_drawer.dart';
import 'models/plan_class.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Radius App',
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.buildLightTheme(),
      darkTheme: ThemeManager.buildDarkTheme(),
      home: MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  Subscription? _selectedSubscription;
  Plan? _selectedPlan;
  List<Subscription> _subscriptions = [];
  final DataSyncScheduler scheduler = DataSyncScheduler(
    interval: Duration(minutes: 30),
  );
  DateTime? lastSyncedTime;
  String syncStatus = "Not synced yet";

  final List<String> _pageTitles = [
    'Dashboard',
    'Subscriptions',
    'Users',
    'Plans',
    'Poles',
    'Settings',
    'Profile',
    'Subscription Details',
    'Plan Details',
    'All Poles',
    'Pole Paths',
  ];

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
    scheduler.start();
    scheduler.addListener(_updateSyncStatus);
  }

  @override
  void dispose() {
    scheduler.stop();
    scheduler.removeListener(_updateSyncStatus);
    super.dispose();
  }

  void _updateSyncStatus() {
    setState(() {
      lastSyncedTime = scheduler.lastSyncedTime;
      syncStatus = scheduler.syncStatus;
    });
  }

  Future<void> _loadSubscriptions() async {
    try {
      Map<String, dynamic> result = await fetchSubscriptions(1, 100); // Fetch initial page of subscriptions
      setState(() {
        _subscriptions = result['subscriptions'];
      });
    } catch (error) {
      print('Error loading subscriptions: $error');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSubscriptionSelected(Subscription subscription) {
    setState(() {
      _selectedSubscription = subscription;
      _selectedIndex = 7; // Index for the subscription details page
    });
  }

  void _onPlanSelected(Plan plan) {
    setState(() {
      _selectedPlan = plan;
      _selectedIndex = 8; // Index for the plan details page
    });
  }

  void _onViewMorePlans() {
    setState(() {
      _selectedIndex = 3; // Index for the plans page
    });
  }

  void _onPolesCardTapped(int cardIndex) {
    setState(() {
      _selectedIndex = cardIndex == 1 ? 9 : 10; // 9 for All Poles, 10 for Pole Paths
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        subscriptions: _subscriptions,
        onViewAllPressed: () => _onItemTapped(1),
        onSubscriptionSelected: _onSubscriptionSelected,
        onViewMorePlans: _onViewMorePlans,
        lastSyncedTime: lastSyncedTime,
        syncStatus: syncStatus,
      ),
      SubscriptionsPage(
        onSubscriptionSelected: _onSubscriptionSelected,
        lastSyncedTime: lastSyncedTime,
        syncStatus: syncStatus,
      ),
      UsersPage(
        lastSyncedTime: lastSyncedTime,
        syncStatus: syncStatus,
      ),
      PlansPage(
        onPlanSelected: _onPlanSelected,
        lastSyncedTime: lastSyncedTime,
        syncStatus: syncStatus,
      ),
      PolesMainPage(onCardTapped: _onPolesCardTapped), // PolesMainPage
      const SettingsPage(),
      const ProfilePage(),
      _selectedSubscription != null
          ? SubscriptionDetailsPage(subscription: _selectedSubscription!)
          : Container(),
      _selectedPlan != null
          ? PlanDetailsPage(plan: _selectedPlan!)
          : Container(),
      const PolesPage(), // All Poles Page
      const PolesPathPage(), // Pole Paths Page
    ];

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            selectedIndex: _selectedIndex,
            onItemSelected: _onItemTapped,
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}
