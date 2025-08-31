import time
import os
import json
import google.generativeai as genai
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

# NOTE: This path will need to be configured by the user.
# It should point to the directory of the FS22_GeminiIntegration mod.
MOD_DIRECTORY = "../FS22_GeminiIntegration"
DATA_FILE = "gemini_data.json"
RESPONSE_FILE = "gemini_response.txt"
DATA_FILE_PATH = os.path.join(MOD_DIRECTORY, DATA_FILE)
RESPONSE_FILE_PATH = os.path.join(MOD_DIRECTORY, RESPONSE_FILE)

# Configure the Gemini API
# The user needs to set the GEMINI_API_KEY environment variable.
try:
    genai.configure(api_key=os.environ["GEMINI_API_KEY"])
    model = genai.GenerativeModel('gemini-pro')
except KeyError:
    print("Error: GEMINI_API_KEY environment variable not set.")
    print("Please set the environment variable and restart the script.")
    exit()


class DataFileHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if event.src_path == DATA_FILE_PATH:
            print(f"Data file {DATA_FILE_PATH} has been modified.")
            try:
                with open(DATA_FILE_PATH, 'r') as f:
                    data = json.load(f)

                money = data.get('money', 'unknown')
                dayTime = data.get('dayTime', 'unknown')

                prompt = (
                    "I am playing Farming Simulator 22. My farm currently has "
                    f"${money}. The game time is {dayTime}. "
                    "Give me some advice on what to do next."
                )

                print("Sending prompt to Gemini API...")
                response = model.generate_content(prompt)

                print("--- Gemini Response ---")
                print(response.text)
                print("-----------------------")

                # Write the response to a file for the mod to read
                with open(RESPONSE_FILE_PATH, 'w') as f:
                    f.write(response.text)
                print(f"Response written to {RESPONSE_FILE_PATH}")

            except json.JSONDecodeError:
                print(f"Error: Could not decode JSON from {DATA_FILE_PATH}")
            except Exception as e:
                print(f"An error occurred: {e}")


if __name__ == "__main__":
    print(f"Starting helper, watching for changes in {DATA_FILE_PATH}")
    event_handler = DataFileHandler()
    observer = Observer()
    observer.schedule(event_handler, MOD_DIRECTORY, recursive=False)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
