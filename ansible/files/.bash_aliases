alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'
alias open=xdg-open
#git
alias gpull="git pull"
alias gfetch="git fetch"
alias gmerge="git merge"
alias gbranch="git branch"
alias newbranch="git checkout -b"
alias gsign="git config --global user.signinkey"
#DOCKER
alias dimages="docker images"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dprune="docker system prune -af"
#grep
alias grep="grep --color=auto"
#pbcopy
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
#apt
alias apt-get='sudo apt-get'
alias update='sudo apt-get update && sudo apt-get upgrade'
#vim
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'
#utils
alias trash="mv --force -t ~/.local/share/Trash $1"
alias rel='lsb_release -r'
alias rel='lsb_release -a'
alias ..='cd ..'


greset() {
    git reset --hard HEAD~$1
}
#GIT
#######################################
# use example
# $ gcommit initial commit
# $ gcommit "initial commit"
# git pull, git add, git commit & git push
# ARGUMENTS:
#   String to commits description
# OUTPUTS:
#   void
# RETURN:
#   0 if print succeeds, non-zero on error.
#######################################
gcommit() {
    #Get tag 
    GIT_TAG=`git tag | tail -1`
    if [ -f package.json ]; then
        #if exist package.json, will modify file using the gegex: (.*"version".*)"[\d\.]+",
        sed -i -E 's/(.*"version".*)"[[:digit:]\.]+",/\1"'"${GIT_TAG:-1.0.0}"'",/g' package.json #| grep version
       
        #run test
        read -p "do you want to run tests? (y\N):" TEST
        #if you write "y" or "Y", will run test
        [[ ${TEST^} == "Y" ]] && npm run test
    fi
    #pull commits and add files to git
    git pull
    git add --all && git commit -m "$*"

    #get all commits unpushed
    COMMITS=$(git cherry -v | wc -l || echo 0)
    read -p "do you want to push ($COMMITS) commit(s)? (y\N):" PUSH

    #if you write "y" or "Y", will push all commits unpushed
    [[ ${PUSH^} == "Y" ]] && git push origin --all
}
gcfeat(){
    gcommit "[feat] $@"
}
gcadd(){
    gcommit "[feat] $@"
}
gcrm(){
    gcommit "[feat] $@"
}
gcfix(){
    gcommit "[fix] $@"
}
gcupdate(){
    gcommit "[update] $@"
}
gcrefactor(){
    gcommit "[refactor] $@"
}
gstash(){
    git add --all
    git stash $@
}
gtag(){
    if [[ "$@" == "" ]]
    then
        git tag
    else
         git tag -a $1 -m "$2"
        read -p "push tags? (Y/n)" push
        [[ "${push^}" != "Y" ]]  && git push origin --tags
    fi
}
ipv4(){
    hostname -I | awk '{print $1}'
}
# display messages
if [[  "$TERM_PROGRAM" != "vscode" ]]; then
    neofetch
fi
export IP_HOST=`ipv4`