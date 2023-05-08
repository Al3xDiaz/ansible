if [[ -d .git ]]
then
    export git_remote=`git remote`
    export git_branch=`git branch --show-current`
fi
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'
alias open=xdg-open
alias gpull="git pull"
alias gfetch="git fetch"
alias gmerge="git merge"
alias gbranch="git branch"
alias newbranch="git checkout -b"
alias gsign="git config --global user.signinkey"
alias dimages="docker images"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dprune="docker system prune -af"
alias grep="grep --color=auto"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias apt-get='sudo apt-get'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'
alias trash="mv --force -t ~/.local/share/Trash $1"
alias rel='lsb_release -r'
alias rel='lsb_release -a'
alias ..='cd ..'
password() {
    echo $@ | base64 | pbcopy
    pbcopy -o
}
greset() {
    git reset --hard HEAD~$1
}
gcommit() {
    rm -rf .git/index.lock
    GIT_TAG=`git tag | tail -1`
    git add --all && git commit -m "$*"
    COMMITS=$(git cherry -v | wc -l || echo 0)
    read -p "do you want to push ($COMMITS) commit(s)? (Y/n):" PUSH
    [[ ${PUSH^} != "N" ]] && git push --set-upstream $git_remote $git_branch
}
gcfeat(){
    gcommit "[feat] $@"
}
gcadd(){
    gcommit "[add] $@"
}
gcrm(){
    gcommit "[remove] $@"
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
if [[  "$TERM_PROGRAM" != "vscode" ]]; then
    figlet -cl "Debian 10"
fi
export IP_HOST=`ipv4`
PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$IP_HOST\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \n↳$ "
