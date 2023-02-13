# Quick Nuxt

A simple shell script to quickly create and deploy a Nuxt.js application to Github and Vercel.


### Prerequisites

- `jq` and `curl` must be installed on your machine. If they are not installed, the script will attempt to install them automatically.
- A [Github personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) must be obtained and passed to the script as an argument or set as an environment variable GITHUB_PAT.

### Getting started

- In order to use the script, you will need to clone the repository to your local machine. You can do this by running the following command in your terminal or Git Bash:
```
git clone https://github.com/vinosamari/quick-nuxt.git
```

- After cloning the repository, navigate to the script directory using the following command:
```
cd quick-nuxt
```

- Now, you need to make the script executable. You can do this by running the following command:
```
chmod +x quick-nuxt.sh
```


## Usage
At least 2 arguments are required:
- `APP_NAME`: the name of your Nuxt.js application.
- `GITHUB_USERNAME`: your Github username.

```
#If $GITHUB_PAT not set in environment variables

./quick-nuxt.sh APP_NAME GITHUB_USERNAME GITHUB_PAT
```


#### Alternatively you can save the token as an environment variable;
```
export GITHUB_PAT=abcdefghijklmnopqrstuvwxyz1234567890

./quick-nuxt.sh my-new-repo vinosamari

```

### TODO
- Allow for different app and repo names
- Allow repo to be private
