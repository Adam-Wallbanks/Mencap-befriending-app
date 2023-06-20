import 'dart:core';

int MobileWidth = 700;
int MobileHeight = 850;


int MinimumOne(int num)
{
  return  num < 0 ? num : 1;
}

List<int> LoginWidthFlex(double maxWidth)
{
  int totalFlex = (maxWidth / 10).round();
  double flexFactor = (6 - (maxWidth / 500)).clamp(1, 8);
  int mainFlex = flexFactor.round();
  int borderFlex = MinimumOne(((10-mainFlex)/2).round());
  List<int> flexes = [mainFlex, borderFlex];
  return flexes;
}