# FS22 Gemini Addon

This is a mod for Farming Simulator 22 that integrates Google Gemini AI for dynamic game modification. You can chat with the Gemini AI to modify game files on the fly.

## Installation

1.  Run the `install.bat` script. It will ask for the path to your Farming Simulator 22 mods directory.
2.  Activate the mod in the game.

## Configuration

Before using the mod, you need to configure your Google Gemini API key.

1.  Open the `FS22_GeminiAddon/geminiConfig.xml` file.
2.  Replace `YOUR_API_KEY_HERE` with your actual Google Gemini API key.
3.  You can obtain a key from [Google AI Studio](https://aistudio.google.com/app/apikey).

## Usage

Press `F7` to toggle the Gemini chat window. You can then type your requests to the AI.

**Example:**

To change the capacity of a vehicle, you could type a prompt like:
`FILE:vehicles/lemken/saphir7/saphir7.xml CODE:<vehicle><fillUnit ... capacity="10000" ... /></vehicle>`

The AI will then try to apply this change to the specified file.

**Disclaimer:** This mod modifies game files. Always back up your savegame and important files before using it. The self-modification feature is experimental and can have unintended consequences.
