# Password Stealer

This repository contains a script written in AutoIt that steals passwords from Google Chrome's saved login data and writes them to a file. Please note that the use of such scripts for malicious purposes is illegal and unethical. This code is provided for educational purposes only.

## Prerequisites
To run this script, you need to have the following:

- AutoIt: The script is written in AutoIt, so make sure you have AutoIt installed on your system.
- Array.au3: This script utilizes the `Array` library, which is included in the AutoIt standard library.
- SQLite.au3: This script utilizes the `SQLite` library, which is included in the AutoIt standard library.
- SQLite.dll.au3: This script utilizes the `SQLite.dll` library, which is included in the AutoIt standard library.
- File.au3: This script utilizes the `File` library, which is included in the AutoIt standard library.

## Usage
1. Clone or download the repository to your local machine.
2. Ensure that you have met the prerequisites mentioned above.
3. Open the script in AutoIt.
4. Compile the script to an executable file (optional).
5. Run the script.

The script will search for Google Chrome's saved login data file (`Login Data`) and extract the login URLs, usernames, and passwords. It will then write this information to a file named `Passwords.txt` in the same directory as the script.

Please exercise caution and use this script responsibly and legally.

## Disclaimer
This script is provided for educational purposes only. The use of this script to steal passwords or engage in any illegal activities is strictly prohibited. The author and the contributors are not responsible for any misuse or damage caused by this script.
