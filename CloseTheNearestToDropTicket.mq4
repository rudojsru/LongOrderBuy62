//+------------------------------------------------------------------+
//|                                  CloseTheNearestToDropTicket.mq4 |
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
   string Symb=Symbol();
   double Dist =10000000;
   int Real_Order=-1;
   double Win_Price=WindowPriceOnDropped();
   //---------
   int Ticket=0;
   double Lot=0;
   
      for (int i=1; i<=OrdersTotal(); i++) {
         if (OrderSelect(i-1,SELECT_BY_POS)==true) {
          //---------------------
          if (OrderSymbol()!=Symb) continue;
          int Tip=OrderType();
          if (Tip>1) continue;
          //----------------------
          double Price=OrderOpenPrice();
             if(NormalizeDouble(MathAbs(Price-Win_Price),Digits)< NormalizeDouble(Dist,Digits)) {
              Dist=MathAbs(Price-Win_Price);
              Real_Order=Tip;
              Ticket= OrderTicket();
              Lot=OrderLots(); 
             }
         } 
      }
     while(true){
        if (Real_Order == -1){
        Alert("Po ",Symb," rincznix orderow net");
        break;
        }
     //---------------
     double Price_Cls=Bid;
     string Text="Buy";
     switch(Real_Order){
     case 0:   Price_Cls=Bid;
               Text="Buy";
             break;
     case 1:  Price_Cls=Ask;
              Text="Sell";
     }
     Alert("Poptka zakrit ", Text," ", Ticket,". Ozidanije otweta..");
     bool Ans=OrderClose(Ticket,Lot, Price_Cls,2);
     //-------------------
     if(Ans==true){
     Alert("Zakrit order ",Text,"  ",Ticket);
     break;
     }
     // --------------checked
    int Error=GetLastError();
    switch(Error) {
      case 135:Alert("Price has changed");
      RefreshRates();
      continue;
      case 136:Alert("No prices, waiting for a new tick");
         while(RefreshRates()==false)
               Sleep(1);
               continue;
      case 146: Alert("Trading subsystem is busy");
                Sleep(400);
                RefreshRates();
                continue;
    }
   //------------- unchecked 
    switch(Error){
    case 2:Alert("General error");
           break;
    case 5:Alert("Old client terminal version");
           break;
    case 133:Alert("Trade is prohibited");
           break;
    default: Alert(" Error number:",Error);
    }
   break;
   }
   Alert(" skript zakonczil rabotu -------------------");
    
  }
     
       
 
//+------------------------------------------------------------------+
