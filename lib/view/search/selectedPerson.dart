import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/view/search/searchView.dart';

class SelectedPersonView extends StatefulWidget {
  const SelectedPersonView({super.key});

  @override
  State<SelectedPersonView> createState() => _SelectedPersonViewState();
}

class _SelectedPersonViewState extends State<SelectedPersonView> {
  final GetRole getRole = GetRole();
  List<Role> roles = [];
  List<Role> filteredRoles = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    try {
      final fetchedRoles = await getRole.allRole();
      setState(() {
        roles = fetchedRoles;
        filteredRoles = fetchedRoles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

// Filter the role according to the input
  void filterRoles(String query) {
    final List<Role> results = roles
        .where((role) => role.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredRoles = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Topic"),
      ),
      body: GridView.builder(
        itemCount: filteredRoles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _buildQuickActionButton(size, filteredRoles[index].title);
        },
      ),
    );
  }

  Widget _buildQuickActionButton(
    Size size,
    String displayName,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: size.height * 0.12,
        width: size.width * 0.5,
        decoration: BoxDecoration(
            color: AppColors.emeraldGreen,
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Positioned(
              left: size.width * 0.16,
              top: size.height * 0.02,
              child: CircleAvatar(
                radius: size.height * 0.045,
              ),
            ),
            Positioned(
              left: size.width * 0.10,
              top: size.height * 0.12,
              child: Text(
                displayName,
                style: TextStyle(
                    fontSize: size.height * 0.025, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              left: size.width * 0.10,
              top: size.height * 0.155,
              child: Text(
                "Email@gamil.com",
                style: TextStyle(
                    fontSize: size.height * 0.02, fontWeight: FontWeight.w500),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  Container(
                    height: size.height * 0.05,
                    width: size.width * 0.455,
                    decoration: BoxDecoration(
                        color: AppColors.emeraldGreenLight,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          // topLeft: Radius.circular(20),
                          // topRight: Radius.circular(20)
                        )),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.call),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Call",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
