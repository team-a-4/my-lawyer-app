import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class FinesCardSkeleton extends StatefulWidget {
  const FinesCardSkeleton({super.key});

  @override
  State<FinesCardSkeleton> createState() => _FinesCardSkeletonState();
}

class _FinesCardSkeletonState extends State<FinesCardSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
        isLoading: true,
        skeleton: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[300],
          ),
        ),
        child: Text("Skeleton"));
  }
}
