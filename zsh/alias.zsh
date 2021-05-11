# Browser
alias firefox="firefox </dev/null &>/dev/null &"
alias chromium="chromium </dev/null &>/dev/null &"

# Kubernetes
alias k=kubectl

# Python
alias python=`which python3`                                                                                                                                                                                       
alias pip=`which pip3`  

# Git
alias git-bc="git fetch origin --prune && git branch -v | grep \"\[gone\]\" | awk '{print \$1}' | xargs git branch -D"
