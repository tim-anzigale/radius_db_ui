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
import 'theme_provider.dart';
import './theme/theme_manager.dart';
import 'navigation_drawer.dart';
import 'models/plan_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch subscription data
  List<Subscription> subscriptions = await fetchSubscriptions();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(subscriptions: subscriptions),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<Subscription> subscriptions;

  const MyApp({Key? key, required this.subscriptions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Radius App',
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.buildLightTheme(),
      darkTheme: ThemeManager.buildDarkTheme(),
      home: MainLayout(subscriptions: subscriptions),
    );
  }
}

class MainLayout extends StatefulWidget {
  final List<Subscription> subscriptions;

  const MainLayout({super.key, required this.subscriptions});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  Subscription? _selectedSubscription;
  Plan? _selectedPlan;

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
        subscriptions: widget.subscriptions,
        onViewAllPressed: () => _onItemTapped(1),
        onSubscriptionSelected: _onSubscriptionSelected,
        onViewMorePlans: _onViewMorePlans,
      ),
      SubscriptionsPage(
        subscriptions: widget.subscriptions,
        onSubscriptionSelected: _onSubscriptionSelected,
      ),
      const UsersPage(), // Pass users list or fetch and pass dynamically
      PlansPage(onPlanSelected: _onPlanSelected),
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
