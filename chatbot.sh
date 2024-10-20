#!/bin/bash

# Ensure that OpenAI API key is set
if [[ -z "$OPENAI_API_KEY" ]]; then
    echo "Error: OpenAI API key not set. Please set it in the OPENAI_API_KEY environment variable."
    exit 1
fi

# Function to escape JSON special characters
escape_json() {
    echo "$1" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\//\\\//g; s/\b/\\b/g; s/\f/\\f/g; s/\n/\\n/g; s/\r/\\r/g; s/\t/\\t/g'
}

# Function to get AI response from OpenAI API
get_ai_response() {
    local prompt="$1"
    
    # Escape the prompt for JSON
    escaped_prompt=$(escape_json "$prompt")

    # Create a valid JSON payload
    json_payload=$(cat <<EOF
{
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "$escaped_prompt"}],
    "max_tokens": 50,
    "n": 1,
    "temperature": 0.7
}
EOF
)

    # Send request to OpenAI's chat API using curl
    response=$(curl -s https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "$json_payload")

    # Debug: Print the full API response for troubleshooting
    echo "Full API Response: $response"

    # Check if there's an error in the API response
    if echo "$response" | jq -e .error > /dev/null; then
        echo "Error: $(echo "$response" | jq -r .error.message)"
        return
    fi
    
    # Parse the AI response using jq and trim leading/trailing spaces
    ai_response=$(echo "$response" | jq -r '.choices[0].message.content' | sed 's/^ *//; s/ *$//')
    
    # If no response, provide a default message
    if [[ -z "$ai_response" ]]; then
        ai_response="Sorry, I didn't get that. Could you please ask again?"
    fi

    echo "$ai_response"
}

# Chat loop
echo "Welcome to the Chatbot! Type 'exit' to quit."
while true; do
    # Get user input
    read -p "You: " user_input
    
    # Exit if the user types 'exit'
    if [[ "$user_input" == "exit" ]]; then
        echo "Goodbye!"
        break
    fi
    
    # Get the AI's response from OpenAI API
    ai_response=$(get_ai_response "$user_input")
    
    # Display the AI response
    echo "AI: $ai_response"
done

