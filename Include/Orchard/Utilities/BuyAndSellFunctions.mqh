/*

 */

#property copyright "Copyright 2012-2020, Orchard Forex"
#property link      "https://www.orchardforex.com"
#property strict

/*
	This code shows using the helper functions
	
*/

//
//	How the example code could look
//
double	GetStopLossPrice(int orderType, double orderPrice, double stopLoss) {

	double	stopLossPrice	=	Sub(orderPrice, stopLoss, orderType);
	
	return(stopLossPrice);
	
}

double	GetStopLossValue(int orderType, double orderPrice, double stopLossPrice) {

	double	stopLoss	=	Dif(orderPrice, stopLossPrice, orderType);
	
	return(stopLoss);
	
}

//
//	These are the helper functions
//	All expect that the order type is one of the buy or sell constants,
//		there is no error handling here for an invalid value
//

//
//	Mult, to get the mathematical sign of the trade direction
//
int	Mult(int orderType) {

	//	For readability
	return( (orderType==OP_BUY || orderType==OP_BUYLIMIT || orderType==OP_BUYSTOP) ? 1 : -1 );
	
	//	or if you prefer, relies on the integer values of buy and sell constants
	return((int)(MathMod(orderType,2)*-2)+1);
	
}

//
//	To solve a common problem, deciding which is the correct price to use
//		to open or close a trade
//
double	OpenPrice(string symbol, int orderType) {

	return(
		(orderType==OP_BUY || orderType==OP_BUYLIMIT || orderType==OP_BUYSTOP) ?
			MarketInfo(symbol, MODE_ASK) :
			MarketInfo(symbol, MODE_BID)
			);
			
}

double	ClosePrice(string symbol, int orderType) {

	return(
		(orderType==OP_BUY || orderType==OP_BUYLIMIT || orderType==OP_BUYSTOP) ?
			MarketInfo(symbol, MODE_BID) :
			MarketInfo(symbol, MODE_ASK)
			);
			
}

//
//	The following are the math functions.
//	Instead of using conditions to determine if comparisons
//		or calculations should be positive or negative these
//		allow you to think of all trades in their relative
//		positive direction
//

//
//	For comparisons, GT, GE, LT, LE
//

bool	GT(double v1, double v2, int orderType) {

	//	read as v1 > v2
	return( ((v1-v2)*Mult(orderType))>0 );
	
}

bool	GE(double v1, double v2, int orderType) {

	//	read as v1 >= v2
	return( ((v1-v2)*Mult(orderType))>=0 );
	
}

bool	LT(double v1, double v2, int orderType) {

	//	read as v1 < v2
	return( ((v1-v2)*Mult(orderType))<0 );
	
}

bool	LE(double v1, double v2, int orderType) {

	//	read as v1 <= v2
	return( ((v1-v2)*Mult(orderType))<=0 );
	
}

double	Add(double v1, double v2, int orderType) {

	//	read as v1 + v2
	return(v1 + (v2*Mult(orderType)));
	
}

double	Sub(double v1, double v2, int orderType) {

	//	read as v1 - v2
	return(v1 - (v2*Mult(orderType)));
	
}

double	Dif(double v1, double v2, int orderType) {

	//	In the world of negatives sub is good for calculating
	//	a target value from a starting position but cannot be
	//	used to calculate the difference between 2 prices
	//	so we need dif
	return((v1 - v2)*Mult(orderType));
	
}

//
//	And some overload functions, in selected cases
//

//
//	In case you are only working with the on chart symbol
//

double	OpenPrice(int orderType)	{	return(OpenPrice(Symbol(), orderType));	}
double	ClosePrice(int orderType)	{	return(ClosePrice(Symbol(), orderType));	}


/*
	The code below is an example of code without the helper functions
	
//
//	An example of code dealing with buy and sell directions
//

double	GetStopLossPrice(int orderType, double orderPrice, double stopLoss) {

	double	stopLossPrice	=	0;
	if (orderType==OP_BUY || orderType==OP_BUYLIMIT || orderType==OP_BUYSTOP) {
		stopLossPrice	=	openPrice - stopLoss;
	} else {
		stopLossPrice	=	openPrice + stoploss;
	}
	
	return(stopLossPrice);
	
}

double	GetStopLossValue(int orderType, double orderPrice, double stopLossPrice) {

	double	stopLoss	=	0;
	if (orderType==OP_BUY || orderType==OP_BUYLIMIT || orderType==OP_BUYSTOP) {
		stopLoss	=	orderPrice - stopLossPrice;
	} else {
		stopLoss	=	stopLossPrice - orderPrice;
	}
	
	return(stopLoss);
	
}

*/