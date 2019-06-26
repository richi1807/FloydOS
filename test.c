#include<stdio.h>
extern void foo();
int main()
{
	foo();
	return 0;
}
void test(int p)
{
	printf("The value of p = %d\n" ,p);
	return ;
}
