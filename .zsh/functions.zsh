# Automatically run ls when cd-ing into a directory
cd() {
    builtin cd $* && ls;
}

crun() {
 	g++ "$1" && ./a.out
}

server() {
	local port="${1:-8000}"
	open "http://localhost:${port}/"
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

budoLive() {
	budo index.js --live | garnish -- -t babelify
}

gi() {
	curl https://www.gitignore.io/api/"$@";
}

hsearch() { 
	history | grep $1 | grep -v hsearch; 
}