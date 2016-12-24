# Go

## 0. 설치

참고 링크: [vsouza gist](https://gist.github.com/vsouza/77e6b20520d07652ed7d)

- `.zshrc` or `.bashrc` 파일에 추가

    ```sh
    export GOPATH=$HOME/golang
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin
    ```

- `install.sh` 파일을 다음 코드로 만들어서 실행

    ```sh
    echo "Please enter your golang path (ex: $HOME/golang) :"
    read gopath

    echo "Please enter your github username (ex: vsouza) :"
    read user


    mkdir $gopath
    mkdir -p $gopath/src/github.com/$user

    export GOPATH=$gopath
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brew install go
    brew install git
    brew install mercurial

    go get golang.org/x/tools/cmd/godoc
    go get golang.org/x/tools/cmd/vet

    echo "go to https://golang.org/doc/code.html and enjoy :D"
    ```
