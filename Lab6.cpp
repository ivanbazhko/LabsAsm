#include <iostream>
#include <iomanip>
using namespace std;
#pragma inline
float enc(const std::ios& stream);
int main() {
	setlocale(LC_ALL, "Russian");
	int num = 10;
	float* arr = new float[num];
	cout << "Введите элементы массива: \n";
	for (int i = 0; i < num; i++) { //Ввод массива
		cout << i + 1 << ": ";
		arr[i] = enc(std::cin);
	};
	float k = 0, o = num;
	_asm {
		mov esi, [arr]
		mov ecx, num
		mov ebx, 0
		fld k
		lp:
		fadd dword ptr[esi + 4 * ebx] //Сложение элементов массива
		inc ebx
		loop lp
		fdiv o
		fstp k
	};
	cout << setfill('-') << setw(79) << "-" << setfill(' ') << endl << "Результат: " << k << endl;
	return 0;
}



float enc(const std::ios& stream) { //Ввод натурального числа
	float y = 0;
	int par = 0;
	do {
		try {
			rewind(stdin);
			cin >> y;
			rewind(stdin);
			if (!stream.good()) { //Проверка, является ли число положительным
				par = 1;
				throw 1;
			};
			par = 0;
		}
		catch (int) {
			cout << "\x1B[31mIncorrect. Try again\033[0m" << endl;
			par = 1;
			cin.clear();
		};
	} while (par);
	return y;
}
