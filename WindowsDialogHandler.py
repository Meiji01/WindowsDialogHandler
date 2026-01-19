#!/usr/bin/env python3
"""
Windows Dialog Handler - Python Edition
Opensource automation tool for setting file paths in Windows file dialogs
"""

import sys
import time
import ctypes
from ctypes import wintypes

# Windows API functions
FindWindow = ctypes.windll.user32.FindWindowW
GetDlgItem = ctypes.windll.user32.GetDlgItem
SendMessage = ctypes.windll.user32.SendMessageW
Sleep = ctypes.windll.kernel32.Sleep

# Windows constants
WM_SETTEXT = 12
BM_CLICK = 245
IDOK = 1


def main():
    print("Welcome to Windows Dialog Handler! Opensource automation tool by Meij Racpan")
    print("You have to follow the argument descriptors as below:")
    print("<window class name> <window title> <edit box control ID> <file path to set> <set delay in milliseconds>")
    print("Default values will be used if no arguments are provided.")
    print("Example: WindowsDialogHandler.py #32770 \"Choose File to Upload\" 1148 \"C:\\Path\\To\\File.txt\" 500")
    print(f"Argument count is {len(sys.argv)}")

    # Default values
    class_name = "#32770"
    window_title = "Choose File to Upload"
    edit_box_id = 0x47C
    file_path = "C:\\WorkingFolder\\Programming\\IE2\\ForUpload.txt"
    delay = 500

    # Check if arguments are provided and use them, otherwise use defaults
    if len(sys.argv) >= 2:
        class_name = sys.argv[1]
        print(f"Using window class from argument: {class_name}")
    
    if len(sys.argv) >= 3:
        window_title = sys.argv[2]
        print(f"Using window title from argument: {window_title}")
    
    if len(sys.argv) >= 4:
        try:
            edit_box_id = int(sys.argv[3], 0)  # 0 base allows hex with 0x prefix
            print(f"Using edit box control ID from argument: {sys.argv[3]}")
        except ValueError:
            print(f"Invalid edit box ID: {sys.argv[3]}")
            return 0
    
    if len(sys.argv) >= 5:
        file_path = sys.argv[4]
        print(f"Using file path from argument: {file_path}")
    
    if len(sys.argv) >= 6:
        try:
            delay = int(sys.argv[5])
            print(f"Using delay from argument: {sys.argv[5]} ms")
        except ValueError:
            print(f"Invalid delay: {sys.argv[5]}")
            return 0

    # Find the window
    hwnd = FindWindow(class_name, window_title)
    
    if hwnd:
        print("Dialog Found!")

        # Get the edit box handle
        hdit = GetDlgItem(hwnd, edit_box_id)

        if hdit:
            # Add a small delay to ensure the dialog is ready
            Sleep(delay)

            # Set the file path to the Edit Box using SendMessage
            SendMessage(hdit, WM_SETTEXT, 0, file_path)
            print("File Path Set to Edit Box")

            # Click the Open Button
            hbtn = GetDlgItem(hwnd, IDOK)
            if hbtn:
                # Send Click Message to the Button
                SendMessage(hbtn, BM_CLICK, 0, 0)
            else:
                print("Message: Open Button Not Found!")
        else:
            print("Message: Edit Box Not Found!")
        
        print("Message: Successful!")
        return 1
    else:
        print("Message: Dialog Not Found!")

    return 0


if __name__ == "__main__":
    sys.exit(main())
