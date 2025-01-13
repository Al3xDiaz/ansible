
if [[ -d .git ]] ; then
    export git_remote=`git remote`
    export git_branch=`git branch --show-current`
fi
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'
alias open=xdg-open
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
# git version
alias gversion="[ -d .git/ ] && echo v\$(gitversion /nocache /nofetch /showvariable MajorMinorPatch || git tag | tail -1) || echo 'no version'"
# git commands
alias gsign="git config --global user.signinkey"
gcommit() {
    git status | grep -Po "\t(modified:)?.*"
    git_remote=`git remote`
    git_branch=`git branch --show-current`
    [[ -f inventory ]] && ansible-vault encrypt inventory --vault-password-file .vault_pass.txt || true
    COMMITS=$((`git cherry -v | wc -l || echo 0` + 1))
    read -p "do you want to push ($COMMITS) commit(s)? (Y/n):" PUSH
    rm -rf .git/index.lock
    git add --all && git commit -m "$*"
    [[ ${PUSH^} != "N" ]] && echo "will push $COMMITS commit(s)" && git push -u $git_remote $git_branch
    [[ -f  GitVersion.yml ]] && export VERSION=`gversion` && echo $VERSION
    git fetch
}
greset() {
    git reset --hard HEAD~$1
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
gstash(){
    git add --all
    git stash $@
}
# git commits semantic
# git version x.y.z (major.minor.patch)
# +patch
alias gfix="gcommit \"[fix] $@\""
alias gbug="gcommit \"[bug] $@\""
alias gpatch="gcommit \"[patch] $@\""
alias gupdate="gcommit \"[update] $@\""
# +minor
alias gfeat="gcommit \"[feat] $@\""
alias gminor="gcommit \"[minor] $@\""
# +major
alias grefactor="gcommit \"[refactor] $@\""
alias gbreaking="gcommit \"[breacking] $@\""
alias gmajor="gcommit \"[major] $@\""

ipv4(){
    hostname -I | awk '{print $1}'
}
# if [[  "$TERM_PROGRAM" != "vscode" ]]; then
#    neofetch
#else
export PS1="┌──${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$([[ -d .git ]] && echo \$(git branch --show-current) [\$(gversion)] )\n└$ "
#fi
loadenvs(){
    set -o allexport
    source .env
    set +o allexport
}
export IP_HOST=`ipv4`
export FLYCTL_INSTALL="/home/al3xdiaz/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

