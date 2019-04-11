//+------------------------------------------------------------------+
//|                                                        test1.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
  double k= NormalizeDouble(Close[1],8)+NormalizeDouble(Close[2],8);
  double kk=  Close[1] + Close[2]  ;
  
   Alert(k,Symbol());
   Alert(kk);
  }
//+------------------------------------------------------------------+
