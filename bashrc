# ~/.bashrc: 비로그인 쉘들을 위해 bash(1)에의해 실행.

# 예제에 관해서 (bash-doc 패키지 안에 있는)/usr/share/doc/bash/examples/startup-files를 참고.


# 만약 상호작용하지 않는다면, 어떤한것도 건들지 않습니다.

case $- in

	*i*) ;;

		*) return;;

esac



# 명령어 히스토리에 빈 공간으로 시작하는 라인 또는 중복된 라인을 넣지않는다.

# 좀더 많은 옵션에 대해 bash(1)를 참고.

# HISTCONTROL에 대한 옵션으로 ignoredup와 ignorespace등이 있음.

HISTCONTORL=ignoreboth



# 명령어 히스토리 파일에 덮어 쓰지 않고 추가

shopt -s histappend



# 명령어 히스토리 길이 설정에 대해서 bash(1)에 있는 HISTSIZE와 HISTFILESIZE를 참고.

HISTSiZE=1000

HISTFILESIZE=2000



# 각 명령어 이후에 윈도우 크기를 확인. 만약 필요하다면 라인(행)과 열을 갱신.

shopt -s checkwinsize



# 설정했다면 패스이름 확장 문맥에서 사용되는 '**'패턴은 모든 파일 그리고 0개 또는 그 이상의 디렉토리와 서브 디렉토리에서도 대조.

#shopt -s globstar



# 비텍스트 입력 파일들에 대해 less가 사용하기 좋게 만듬. lesspipe(1)을 참고.

# lesspipe는 lesspipe와 lessfile을 합쳐놓은 프로그램

# lesspipe는 표준출력으로 less파일에 문맥/정보를 입력.

# 이는 lesspipe는 less프로그램이 유저가 파일을 보기전에 디코딩하는 것을 기다릴 필요없게 만듬.

# lessfile은 lesspipe에서 less에 읽힌 이후에 필요없는 파일들을 삭제.

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"



# (프롬프트 하에 사용되어지는) 사용하는 chroot를 식별하는 변수를 설정.

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then

	debian_chroot=$(cat /etc/debian_chroot)

fi



# 화려한 프롬프트를 설정.

case "$TERM" in

	xterm-color) color_prompt=yes;;

esac



# 터미널이 성능이 된다면 색이 입혀진 색으로 입혀진 주석을 사용.;

# 유저의 정신을 혼란하게 만들지 않기 위해 기본값이 해제.: 터미널 창에 초점

# 프롬프트가 아니면 명령어 결과물 이다.

# force_color_prompt=yes



# 위의 force_color_prompt=yes 가 주석처리가 되지 않고,

# Ecma-48과 호환되는 색상 컬러를 갖고 있다면

# 아래의 if문에 의해  color_prompt=yes가 된다.

if [ -n "$force_color_prompt" ]; then

	if [ -x /usr/bin/tput ] && tput setaf 1 > &/dev/null; then

	# 색상지원을 갖고 있으면; ecma-48)ISO/IEC-6429)와 호환

	# 된다고 가정. 이러한 지원 부족은 극히 드문일, 그리고 이러한 경우

	# setaf 보다 setf를 지원하는 경향을 .

	color_prompt=yes

	else

	color_prompt=

	fi

fi



# 위에서 color_prompt의 if문

if [ "$color_prompt" = yes ]; then

	# 설정되어 있으면 아래와 같은 옵션을 갖고 있는 prompt가 됨.

	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'

else

	# if color_prompt=no

	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

fi

#위에서 사용한 color_prompt와 force_color_prompt값을 해제.

unset color_prompt force_color_prompt



# xterm일 경우 제목을 user@host:dir로 설정.

case "$TERM" in

xterm*|rxvt*)

	PS="\[\e]0;${debian_chroot:(debian_chroot)}\u@\h: \w\a\]$PS1"

	;;

*)

	;;

esac



# ls 명령어가 색상 지원을 할 수 있게 만듬. 또한 간단한 명령어도 추가.

# if문에서 /usr/bin/dircolors 실행여부를 확인.

if [ -x /usr/bin/dircolors ]; then

	test -r ~/.dircolors && eval "$(dircolors -b ~/,dircolors)" || eval "$(dircolors -b)"

	#ls 명령어를 ls --color=auto로 변경.

	alias ls='ls --color=auto'

	#alias dir='dir --color=auto'

	#alias vdir='vidr --color=auto'

	

	#grep 명령어를 grep --color=auto로 변경.

	alias grep='grep --color=auto'

	#fgrep 명령어를 fgrep --color=auto로 변경.

	alias frep='frep --color=auto'

	#egrep 명령어를 egrep --color=auto로 변경.

	alias egrep='egrep --color=auto'

fi



# ls 명령어를 추가.

# alias 명령어명='해당 명령어 내용'

# 위와 같은 내용으로 명령어를 추가.

alias ll='ls -alF'

alias la='ls -A'

alias l='ls -CF'



# 장기간 동작하는 명렁어들을 위해 "alter" 명령어를 추가.

# 다음과 같이 사용한다: sleep 10; alert

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\' 's\^\s*[0-9]\+\s*//;s[;&|]\s*alert$//'\'')"'



# 명령어 정의.

# 여기에 직접 명령어들을 추가하는 것 대신에 ~/.bash_aliases같은 분산된 파일들 속에 추가하기 원할수 있음.

# bash-doc 패키지 안에 있는 /usr/share/doc/bash-doc/examples를 참고.

# .bashrc가 아니더라도 외부 파일에 선언된 명령어들을 읽음.

if [ -f ~/.bash_aliases ]; then

	. ~/.bash_aliases

fi



# (/etc/bash.bashrc 와 /etc/profile 안에 이미 사용 가능한 상태라면 이것을 사용할 필요가 없다.) 사용 가능한 프로그래밍의 마지막 특징

if ! shopt -oq posix; then

	if [ -f /usr/share/bash-completion/bash_completion ]; then

		. /usr/share/bash-completion/bash_completion

	elif [-f /etc/bash_completion ]; then

		. /etc/bash_completion

	fi

fi


// 출처 : 구글 bashrc 검색
   번역 : 구글번역을 통해 번역후 간단한 수정
