
#include<Windows.h>
#include "stdafx.h"
#include <array>
#include <iostream>
using namespace std;

//use extern call to call the asm procedure Findlargest that finds the largest element in an array
extern "C" int _stdcall Findlargest(int i[], int count);

int main()
{
	//declare the arrays to have the values searched 
	int arr1[] = { 398, 748, 103, -61, 664, 376, -740, -748, -246, -86, -388, 857, 604, -623, -348 };
	int arr2[] = { 91,100,86,75,77,28,1,16,18,20,22,44,23 };
	int arr3[] = { 301,2,3,4,5,6,5,3,3,2,5,6,7,8,9 };
	int arr4[] = { -90, -8, -1245, -324, -37 };

	// calculate the lengths of the arrays
	int sizea1 = (sizeof(arr1) / sizeof(*arr1));
	int sizea2 = (sizeof(arr2) / sizeof(*arr2));
	int sizea3 = (sizeof(arr3) / sizeof(*arr3));
	int sizea4 = (sizeof(arr4) / sizeof(*arr4));

	//calls the findlargest function which takes in parameters address of the array and the size of the array
	cout << "Largest number in array 1 is " << Findlargest(arr1, sizea1) << endl;
	cout << "Largest number in array 2 is " << Findlargest(arr2, sizea2) << endl;
	cout << "Largest number in array 3 is " << Findlargest(arr3, sizea3) << endl;
	cout << "Largest number in array 4 is " << Findlargest(arr4, sizea4) << endl;



	return 0;
}
