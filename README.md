# Angular Project Generator

This application generates angular code using three different input methods: Figma file, text description, and voice command.


## Features

* **Figma to Angular:** Generate an Angular project directly from your Figma design.
* **Text to Angular:** Describe your desired design in text, and the application will generate the Angular code.
* **Voice to Angular:** Use your voice to describe the design, and the application will convert it into an Angular project.
* **Real-time Feedback:** Track the progress of your project generation with a dynamic progress bar and status updates.
* **Preview:** Preview the generated Angular project directly in your browser.
* **Download:** Download the generated Angular project as a ZIP file.

## Getting Started

1.  **Install Backend Dependencies:** 
    ```bash
    pip3 install whisper
    ```
    ```bash
    pip3 install aws-sdk
    ```

2.  **Install Frontend Dependencies:** Navigate to the frontend part of your project directory in the terminal and run the following command to install the Angular project dependencies:
    ```bash
    npm install
    ```

3.  **Start the Application:** 
    ```bash
    npm start
    ```

## Backend Processing
  **Agentic Workflow:** A series of specialized agents work on your request:
    * **Agent 1:** Fetches data from Figma (if a Figma file is provided) or generates a design structure based on the text or voice input.
    * **Agent 2:** Converts the design structure into Angular code using the Gemini API.
    * **Agent 3:** Verifies and fixes any issues in the generated Angular code.
    * **Agent 4:** Creates the necessary Angular project structure and writes the generated code files.
    * **Agent 5:** Builds the Angular project and prepares it for preview and download.

**Preview and Download Preparation:**
    * The built Angular project files are copied to the `previews` directory.
    * A ZIP file of the entire project is created in the `downloads` directory.
    * The job status is updated to `completed`, and the `previewUrl` and `downloadUrl` are added to the job status.


## Run using docker
```bash
docker-compose up --build
