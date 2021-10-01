# SkillFactory docker

## Install
```bash
docker build --tag skillfactory . # Build
docker run -p 80:5000 --rm --name skillfactory --mount type=bind,src=/home/rubanovich/docker-test/app,dst=/srv/app skillfactory # Run
```