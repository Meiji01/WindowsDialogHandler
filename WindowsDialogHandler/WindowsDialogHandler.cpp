// WindowsDialogHandler.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include<Windows.h>
#include<stdio.h>

//arguments descriptors:
//argument1: Window Class Name
//argument2: Window Title
//argument3: Edit Box Control ID
//argument4: File Path to Set
//argument5: Set Delay in milliseconds
int main(int argc,char* argv[])
{
	printf("Welcome to Windows Dialog Handler! Opensource automation tool by Meij Racpan\n");
	printf("You have to follow the argument descriptors as below:\n");
	printf("<window class name> <window title> <edit box control ID> <file path to set> <set delay in milliseconds>\n");
	printf("Default values will be used if no arguments are provided.\n");
	printf("Example: WindowsDialogHandler.exe #32770 \"Choose File to Upload\" 1148 \"C:\\\\Path\\\\To\\\\File.txt\" 500\n");

	printf("Argument count is %d\n", argc);

	// Default values
	wchar_t className[256] = L"#32770";
	wchar_t windowTitle[256] = L"Choose File to Upload";
	int editBoxIDStr = 0x47C;
	wchar_t filePath[1024] = L"C:\\WorkingFolder\\Programming\\IE2\\ForUpload.txt";
	int indelay = 500;

	// Check if arguments are provided and use them, otherwise use defaults
	if (argc >= 2) {
		MultiByteToWideChar(CP_ACP, 0, argv[1], -1, className, 256);
		printf("Using window class from argument: %s\n", argv[1]);
	}
	if (argc >= 3) {
		MultiByteToWideChar(CP_ACP, 0, argv[2], -1, windowTitle, 256);
		printf("Using window title from argument: %s\n", argv[2]);
	}
	if (argc >= 4) {
		editBoxIDStr = strtol(argv[3], NULL, 0);
		printf("Using edit box control ID from argument: %s\n", argv[3]);
	}
	if (argc >= 5) {
		MultiByteToWideChar(CP_ACP, 0, argv[4], -1, filePath, 1024);
		printf("Using file path from argument: %s\n", argv[4]);
	}
	if (argc >= 6) {
		indelay = atoi(argv[5]);
		printf("Using delay from argument: %s ms\n", argv[5]);
	}

    //std::cout << "Hello World!\n";
    HWND hwnd = FindWindow(className, windowTitle);
    if (hwnd != NULL) {
		//MessageBox(hwnd, L"Dialog Found!", L"Info", MB_OK);
		printf("Dialog Found!\n");

		HWND hedig=GetDlgItem(hwnd, editBoxIDStr); //File name Edit Box ID
		//
		//printf("Edit Box Handle: %p\n", hedig);
		
		if (hedig != NULL) {
			//Add a small delay to ensure the dialog is ready
			Sleep(indelay);
			
			//Set the file path to the Edit Box using SendMessage
			SendMessage(hedig, WM_SETTEXT, 0, (LPARAM)filePath);
			printf("File Path Set to Edit Box\n");

			//Click the Open Button
			HWND hbtn = GetDlgItem(hwnd, IDOK); //Open Button ID
			if (hbtn != NULL) {
				//Send Click Message to the Button
				SendMessage(hbtn, BM_CLICK, 0, 0);
			}
			else {
				//MessageBox(NULL, L"Open Button Not Found!", L"Info", MB_OK);
				printf("Message: Open Button Not Found!\n");
			}
		}
		else {
			//MessageBox(NULL, L"Edit Box Not Found!", L"Info", MB_OK);
			printf("Message: Edit Box Not Found!\n");
		}
        printf("Message: Successful!");
        return 1;

	}
	else {
		//MessageBox(NULL, L"Dialog Not Found!", L"Info", MB_OK);
		printf("Message: Dialog Not Found!\n");
	}
	return 0;


}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
