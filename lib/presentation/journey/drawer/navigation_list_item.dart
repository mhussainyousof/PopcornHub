import 'package:flutter/material.dart';

class NavigationListItem extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const NavigationListItem({super.key});
  const NavigationSubListItem({
    super.key,
    required this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2
            ),
            
          ]
        
        ),
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

class NavigationSubListItem extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const NavigationSubListItem({super.key});
  const NavigationListItem({
    super.key,
    required this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2
            ),
            
          ]
        
        ),
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

}
