import 'package:inomarket/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inomarket/themes/theme_service.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final Size screenSize = MediaQuery.of(context).size;
    // Calculate card width based on screen width
    final double cardWidth = screenSize.width * 0.9;
    // Calculate wallet card height proportionally
    final double walletCardHeight = screenSize.height * 0.25;

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      builder: (
        BuildContext context,
        HomeViewmodel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: ThemeService.currentColorScheme.primaryColor,
            elevation: 0,
          ),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.05,
                    vertical: screenSize.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wallet Card
                      SizedBox(
                        width: cardWidth,
                        height: walletCardHeight,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ThemeService.currentColorScheme.primaryColor,
                                  ThemeService.currentColorScheme.primaryColor
                                      .withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenSize.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wallet Balance',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenSize.width * 0.04,
                                        ),
                                      ),
                                      SizedBox(
                                          height: screenSize.height * 0.01),
                                      Text(
                                        '\$5,234.00',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenSize.width * 0.07,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '**** **** **** 1234',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenSize.width * 0.045,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      SizedBox(
                                          height: screenSize.height * 0.01),
                                      Text(
                                        'Expires: 12/25',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: screenSize.width * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.03),

                      // Horizontal filter buttons
                      SizedBox(
                        height: screenSize.height * 0.06,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _buildFilterButton(
                              context: context,
                              label: 'All Seller',
                              isSelected:
                                  true, // You can manage this state in your ViewModel
                            ),
                            _buildFilterButton(
                              context: context,
                              label: 'By Place',
                              isSelected: false,
                            ),
                            _buildFilterButton(
                              context: context,
                              label: 'By Day',
                              isSelected: false,
                            ),
                            _buildFilterButton(
                              context: context,
                              label: 'By Hour',
                              isSelected: false,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),

// Details Section
                      SizedBox(
                        width: cardWidth,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenSize.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // All Sellers Section
                                _buildSellerDetails(context),

                                // You can toggle visibility of these sections based on selected filter
                                // _buildPlaceDetails(context),
                                // _buildDayDetails(context),
                                // _buildHourDetails(context),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.03),

                      // Recent Transactions
                      Text(
                        'Recent Transactions',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),

                      // Transaction Cards
                      _buildTransactionCard(
                        context,
                        'Grocery Store',
                        'Dec 15, 2023',
                        '-\$45.50',
                        Icons.shopping_cart,
                      ),
                      _buildTransactionCard(
                        context,
                        'Coffee Shop',
                        'Dec 14, 2023',
                        '-\$6.75',
                        Icons.coffee,
                      ),
                      _buildTransactionCard(
                        context,
                        'Gas Station',
                        'Dec 13, 2023',
                        '-\$35.25',
                        Icons.local_gas_station,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionCard(
    BuildContext context,
    String title,
    String date,
    String amount,
    IconData icon,
  ) {
    final Size screenSize = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.only(bottom: screenSize.height * 0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.04,
          vertical: screenSize.height * 0.01,
        ),
        leading: CircleAvatar(
          radius: screenSize.width * 0.06,
          backgroundColor:
              ThemeService.currentColorScheme.primaryColor.withOpacity(0.1),
          child: Icon(
            icon,
            color: ThemeService.currentColorScheme.primaryColor,
            size: screenSize.width * 0.06,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenSize.width * 0.04,
          ),
        ),
        subtitle: Text(
          date,
          style: TextStyle(
            fontSize: screenSize.width * 0.035,
          ),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenSize.width * 0.04,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
  }) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: screenSize.width * 0.02),
      child: ElevatedButton(
        onPressed: () {
          // Handle filter selection in your ViewModel
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? ThemeService.currentColorScheme.primaryColor
              : Colors.white,
          foregroundColor: isSelected
              ? Colors.white
              : ThemeService.currentColorScheme.primaryColor,
          elevation: isSelected ? 4 : 2,
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: ThemeService.currentColorScheme.primaryColor,
              width: 1,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenSize.width * 0.035,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSellerDetails(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Sellers',
          style: TextStyle(
            fontSize: screenSize.width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenSize.height * 0.02),
        _buildSellerItem(
          context,
          'John\'s Electronics',
          '150 sales',
          Icons.store,
          '4.8',
        ),
        _buildSellerItem(
          context,
          'Mary\'s Fashion',
          '120 sales',
          Icons.shopping_bag,
          '4.7',
        ),
        _buildSellerItem(
          context,
          'Tech Haven',
          '98 sales',
          Icons.devices,
          '4.6',
        ),
      ],
    );
  }

  Widget _buildSellerItem(
    BuildContext context,
    String name,
    String sales,
    IconData icon,
    String rating,
  ) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: screenSize.height * 0.015),
      padding: EdgeInsets.all(screenSize.width * 0.03),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                ThemeService.currentColorScheme.primaryColor.withOpacity(0.1),
            radius: screenSize.width * 0.05,
            child: Icon(
              icon,
              color: ThemeService.currentColorScheme.primaryColor,
              size: screenSize.width * 0.05,
            ),
          ),
          SizedBox(width: screenSize.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.04,
                  ),
                ),
                Text(
                  sales,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: screenSize.width * 0.035,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.02,
              vertical: screenSize.height * 0.005,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: screenSize.width * 0.04,
                ),
                SizedBox(width: screenSize.width * 0.01),
                Text(
                  rating,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: screenSize.width * 0.035,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
