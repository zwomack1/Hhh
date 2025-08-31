# FS22 Gemini Integration Mod

This mod integrates Farming Simulator 22 with the Google Gemini AI to provide you with advice and information about your farm.

## Features

*   Export basic farm data (money, time) to the Gemini AI.
*   Receive advice from Gemini in an in-game display.
*   Customizable keybinding to trigger the export.

## How it Works

This mod consists of two parts:

1.  **An FS22 Mod:** A Lua script that runs inside the game. It gathers information about your farm and writes it to a file. It also displays the response from Gemini in a HUD element.
2.  **A Python Helper Script:** A Python script that runs on your computer in the background. It watches for the data file from the mod, sends the data to the Gemini API, and writes the response to a file that the mod can read.

## Installation

### 1. Install the FS22 Mod

1.  **Zip the mod folder:** The `FS22_GeminiIntegration` folder contains all the necessary files for the mod. You need to create a zip file from this folder. The zip file should have the same name as the folder, i.e., `FS22_GeminiIntegration.zip`. Make sure the files are in the root of the zip file, not inside another folder.
2.  **Copy to mods folder:** Copy the `FS22_GeminiIntegration.zip` file to your FS22 mods folder. This is usually located in:
    *   Windows: `Documents\My Games\FarmingSimulator2022\mods`
    *   Mac: `~/Library/Application Support/FarmingSimulator2022/mods`

### 2. Set up the Python Helper Script

1.  **Prerequisites:** Make sure you have Python 3 installed on your computer.
2.  **Install dependencies:** Open a terminal or command prompt, navigate to the `GeminiHelper` directory, and run the following command to install the required Python libraries:
    ```
    pip install -r requirements.txt
    ```
3.  **Set your Gemini API Key:** You need to get an API key from Google AI Studio.
    *   Go to [https://aistudio.google.com/apikey](https://aistudio.google.com/apikey) to get your key.
    *   You need to set this key as an environment variable named `GEMINI_API_KEY`. How you do this depends on your operating system:
        *   **Windows (Command Prompt):** `setx GEMINI_API_KEY "YOUR_API_KEY"` (restart your command prompt after running this)
        *   **Windows (PowerShell):** `$env:GEMINI_API_KEY="YOUR_API_KEY"`
        *   **macOS/Linux:** `export GEMINI_API_KEY="YOUR_API_KEY"` (you might want to add this to your `.bashrc` or `.zshrc` file to make it permanent)
4.  **Run the helper script:** In the same terminal, run the following command:
    ```
    python run_helper.py
    ```
    You should see a message that the script is watching for changes. Keep this terminal window open while you are playing the game.

## Usage

1.  **Activate the mod:** Start Farming Simulator 22 and activate the "Gemini Integration" mod in the mod selection screen.
2.  **Set the keybinding:** In the game's settings, go to the keybindings menu. You should find a new action called "GEMINI_EXPORT" (it will likely be in the "Vehicle" category). Assign a key to this action.
3.  **Use in-game:**
    *   Load your savegame.
    *   Press the key you assigned to `GEMINI_EXPORT`.
    *   The mod will export your farm's data. The Python script will detect this, call the Gemini API, and get a response.
    *   The response will appear in a display box in the middle of your screen for a few seconds.
