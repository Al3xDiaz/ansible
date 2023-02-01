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
gcommit() {
    git fetch
    #do things with parameters like $1 such as
    git branch
    git add --all
    git status
    git commit -m "$1"
    COMMITS=$(git cherry -v | wc -l || echo 0)
    read -p "do you want to push ($COMMITS) commit(s)? (y\N):" PUSH
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
        read -p "push tags? (yes/No)" push
        [[ "${push^}" == "YES" ]]  && git push origin --tags
    fi
}
ipv4(){
    hostname -I | awk '{print $1}'
}
# print neofetch
[[  "$TERM_PROGRAM" != "vscode" ]] && neofetch