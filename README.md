# Reproduce crashing bug:

```
git clone https://github.com/dancryer/break-docker-for-mac.git
cd break-docker-for-mac
docker build -t break-docker .
docker run -v `pwd`:/www -p 8080:80 -d -i break-docker

ab -n 100000 -c 5 http://127.0.0.1:8080/
```

After about ~12000 requests, ab will report "connection reset by peer" - Docker has crashed with an "unexpected end of file" exception.