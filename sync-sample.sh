#!/bin/bash

while IFS= read -r repo; do
    while IFS= read -r branch; do
        echo "Updating ${repo}/${branch}..."
    done < <(curl -u "${GITHUB_OWNER}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/${GITHUB_OWNER}/${repo}/branches" | jq -r '.[] | select(.name!="master") | .name')
done < <(curl -u "${GITHUB_OWNER}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/users/${GITHUB_OWNER}/repos?per_page=1000" | jq -r '.[] | select(.topics[]=="docker-image") | .name')
