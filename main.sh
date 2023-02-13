#!/bin/bash

echo "
                           ,,
  .g8""8q.                 db        `7MM        `7MN.   `7MF'                        mm
.dP'    `YM.                           MM          MMN.    M                          MM
dM'      `MM `7MM  `7MM  `7MM  ,p6"bo  MM  ,MP'    M YMb   M `7MM  `7MM  `7M'   `MF'mmMMmm
MM        MM   MM    MM    MM 6M'  OO  MM ;Y       M  `MN. M   MM    MM    `VA ,V'    MM
MM.      ,MP   MM    MM    MM 8M       MM;Mm mmmmm M   `MM.M   MM    MM      XMX      MM
`Mb.    ,dP'   MM    MM    MM YM.    , MM `Mb.     M     YMM   MM    MM    ,V' VA.    MM
`"bmmd"'     `Mbod"YML..JMML.YMbmd'.JMML. YA.  .JML.    YM   `Mbod"YML..AM.   .MA.  `Mbmo
MMb
`bood'                                                                               "

# Check if the required number of arguments are provided
if [ "$#" -lt 2 ]; then
    echo ""
    echo "❌ Error: At least 2 arguments are required (APP_NAME, GITHUB_USERNAME, [github_personal_access_token])"
    echo ""
    echo "📖 Read the documentation at https://github.com/vinosamari/quick-nuxt"
    exit 1
fi

app_name=$1
github_username=$2
github_pat=${3:-$GITHUB_PAT}

# Check if the PAT is provided or set as an environment variable
if [ -z "$github_pat" ]; then
    echo ""
    echo "❌ Error: Github PAT not found. Please provide as the third argument or set as the GITHUB_PAT environment variable."
    echo ""
    echo "📖 Read the documentation at https://github.com/vinosamari/quick-nuxt"
    exit 1
fi

# Create a repository for the authenticated user
curl -u "$github_username:$github_pat" https://api.github.com/user/repos -d "{\"name\":\"$app_name\"" | jq '{name: .name, private: .private, html_url: .html_url, description: .description}'
echo "✅ Created Github Repo Successfully"
# Create a Nuxt app using npx
npx create-nuxt-app $app_name

# Navigate into the app directory
cd $app_name

# Add vercel.json file
echo '{
  "version": 2,
  "builds": [
    {
      "src": "nuxt.config.js",
      "use": "@nuxtjs/vercel-builder"
    }
  ]
}' > vercel.json

# Modify the existing package.json file to set the node engine version
jq '. + {"engines": {"node": "16"}}' package.json > package.json.tmp && mv package.json.tmp package.json

# Make an initial commit
git add .
git commit -m "Initial commit"

# Set the repository's remote origin to the Github repository
git remote add origin https://github.com/$github_username/$app_name.git

# Push the code to the Github repository
git push -u origin master

# Connect the repository to Vercel to deploy
vercel
