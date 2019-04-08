//+------------------------------------------------------------------+
//|                                                 LongOrderBuy.mq4 |
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
 int Dist_SL =10;
 int Dist_TP =3;
 double Prots =0.35;
 string Symb=Symbol();
 //------------------------
     while(true){
     int Min_Dist=MarketInfo(Symb,MODE_STOPLEVEL); // min stop los/TP w punktach
     double Min_Lot = MarketInfo(Symb,MODE_MINLOT); //min razmer lota
     double Step = MarketInfo(Symb, MODE_LOTSTEP); // szag izmenenija lotow
     double Free = AccountFreeMargin();
     double One_Lot=MarketInfo(Symb,MODE_MARGINREQUIRED);// stoimost lota
 //--------------------------------
     double Lot =MathFloor(Free*Point/One_Lot/Step)*Step;  //Loti
        if(Lot<Min_Lot){
        Alert("Niechawatajet deneg na ", Min_Lot " lot");
        break;
        }
//--------------------
       if(Dist_SL<Min_Dist){
       Dist_SL=Min_Dist;
       Alert("Yweiczenije  distancii SL =", Dist_SL," pt");          
       }
      double SL=Bid-Dist_SL*Point;
      //----------------------------
       if(Dist_TP<Min_Dist){
       Dist_TP=Min_Dist;
       Alert("Yweiczenije  distancii TP =", Dist_TP," pt");          
       }
      double TP=Bid+Dist_TP*Point;
//-----------------------------------
       Alert("Torgowij prikaz otprawlen na serwer. Ozidaniej otweta..");
       int ticket=OrderSend(Symb, OP_BUY,Lot,Ask,2,SL, TP);
      //-------------------------------
      if( ticket>0){
      Alert("Otkrit order BUY ", ticket);
      break;
      } 
// -------------------------------------------------
 int Error=GetLastError();
 
 
     
     }
   
  }
//+------------------------------------------------------------------+
