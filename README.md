# Windows Dialog Handler

An opensource automation tool for Windows that automatically interacts with Windows file dialogs to set file paths and trigger file selection.

**Author:** Meij Racpan  
**Version:** 1.0.0

## Overview

Windows Dialog Handler is a lightweight command-line utility designed to automate interactions with standard Windows file dialogs (such as "Choose File to Upload" dialogs). It programmatically finds the dialog window, sets the file path in the edit box, and triggers the OK button to automatically select the file. This is useful for legacy projects involving UI automation such as IEDriver and windows UI automation.


## Features

- Automated Windows dialog detection and interaction
- Customizable window class and title matching
- Configurable edit box control ID targeting
- Adjustable delay before file path submission
- Support for command-line arguments with sensible defaults
- Console feedback and logging of operations

## Requirements

- Windows operating system
- Visual C++ runtime
- Administrator privileges may be required for some dialog interactions

## Building

### Prerequisites
- Visual Studio 2022 or later with C++ development tools
- Windows SDK 10.0 or later

### Build Steps
1. Open `WindowsDialogHandler.sln` in Visual Studio
2. Select your desired configuration (Debug or Release) and platform (Win32 or x64)
3. Build the solution (Ctrl+Shift+B)
4. The executable will be generated in the build output directory

## Usage

### Basic Usage (With Defaults)
```bash
WindowsDialogHandler.exe
```

This will use the default values:
- Window Class: `#32770`
- Window Title: `Choose File to Upload`
- Edit Box Control ID: `0x47C`
- File Path: `C:\WorkingFolder\Programming\IE2\ForUpload.txt`
- Delay: `500` milliseconds

### Advanced Usage (With Custom Arguments)
```bash
WindowsDialogHandler.exe <window_class> <window_title> <edit_box_id> <file_path> <delay_ms>
```

### Arguments

| Argument | Description | Example |
|----------|-------------|---------|
| `window_class` | The class name of the dialog window | `#32770` |
| `window_title` | The title/caption of the dialog window | `"Choose File to Upload"` |
| `edit_box_id` | The control ID of the edit box (decimal or hex) | `1148` or `0x47C` |
| `file_path` | The full path to the file to set | `"C:\Path\To\File.txt"` |
| `delay_ms` | Delay in milliseconds before setting the file path | `500` |

### Example

```bash
WindowsDialogHandler.exe #32770 "Choose File to Upload" 1148 "C:\Users\Username\Desktop\document.pdf" 1000
```

## How It Works

1. **Window Detection:** The tool uses Windows API `FindWindow()` to locate the target dialog window based on class name and title.

2. **Edit Box Identification:** Once the window is found, it retrieves the edit box control using `GetDlgItem()` with the specified control ID.

3. **File Path Assignment:** The file path is set in the edit box using `SendMessage()` with the `WM_SETTEXT` message.

4. **Delay:** An optional delay is applied to ensure the dialog is ready before interaction.

5. **Button Click:** The OK button is automatically clicked using `SendMessage()` with the `BM_CLICK` message to confirm the file selection.

## Technical Details

- **Language:** C++ with Windows API
- **Platform:** Windows (x86 and x64)
- **Target Framework:** Win32 Console Application
- **Character Set:** Unicode

## Common Issues

### Dialog Not Found
- Ensure the window class and title match exactly
- Check if the dialog is already open when the tool runs

### Edit Box Not Found
- Verify the edit box control ID is correct
- Use Spy++ (included with Visual Studio) to inspect dialog controls

### Open Button Not Found
- The button should use the standard `IDOK` identifier
- Some custom dialogs may have different button IDs

## Finding Dialog Parameters

To determine the correct parameters for your target dialog:

1. **Use Spy++** (included with Visual Studio):
   - Launch Spy++
   - Use the crosshair tool to select your dialog
   - Note the window class and title
   - Expand the window to see child controls and their IDs

2. **Use Windows Inspector** or similar tools to inspect window properties


## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

The MIT License allows you to use, modify, and distribute this software freely, provided that you include the original copyright notice and license text. You are free to use this code in your personal or commercial projects.

## Support

For issues, questions, or contributions, please refer to the project repository.

---

*Windows Dialog Handler - Opensource automation tool by Meij Racpan*
