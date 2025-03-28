#!/bin/bash
# test-amplify-build.sh

# Load environment variables from .env.local
if [ -f .env.local ]; then
    export $(cat .env.local | xargs)
else
    echo "❌ .env.local file not found!"
    exit 1
fi

# PreBuild Phase
echo "🚀 Starting PreBuild phase..."
npm ci

# Build Phase
echo "🏗️ Starting Build phase..."

# Create .env file
echo "Creating .env file..."
echo "ISSUER_URL=$ISSUER_URL" >> .env
echo "CALLBACK_URL=$CALLBACK_URL" >> .env
echo "LOGOUT_URL=$LOGOUT_URL" >> .env
echo "NEXT_PUBLIC_AUTH0_CLIENT_ID=$NEXT_PUBLIC_AUTH0_CLIENT_ID" >> .env
echo "NEXT_PUBLIC_AUTH0_REDIRECT_URI=$NEXT_PUBLIC_AUTH0_REDIRECT_URI" >> .env
echo "NEXT_PUBLIC_AUTH0_POST_LOGOUT_REDIRECT_URI=$NEXT_PUBLIC_AUTH0_POST_LOGOUT_REDIRECT_URI" >> .env
echo "NEXT_PUBLIC_AUTH0_SCOPE=$NEXT_PUBLIC_AUTH0_SCOPE" >> .env
echo "NEXT_PUBLIC_AUTH0_AUDIENCE=$NEXT_PUBLIC_AUTH0_AUDIENCE" >> .env
echo "NEXT_PUBLIC_AUTH0_USE_REFRESH_TOKEN=$NEXT_PUBLIC_AUTH0_USE_REFRESH_TOKEN" >> .env
echo "NEXT_PUBLIC_AUTH0_DOMAIN=$NEXT_PUBLIC_AUTH0_DOMAIN" >> .env

# Set API URL based on branch
if [ "${AWS_BRANCH}" = "main" ]; then
    echo "NEXT_PUBLIC_API_URL=https://cr38tdnd0a.execute-api.us-east-1.amazonaws.com/dev" >> .env
else
    echo "NEXT_PUBLIC_API_URL=https://cr38tdnd0a.execute-api.us-east-1.amazonaws.com/prod" >> .env
fi

# Run build
npm run build

echo "✅ Build completed!"