FROM nginx

# 配置apt源
RUN sed -i "s/http:\/\/deb.debian.org/http:\/\/mirrors.163.com/g" /etc/apt/sources.list
RUN sed -i "s/http:\/\/security.debian.org/http:\/\/mirrors.163.com/g" /etc/apt/sources.list

# 安装必需组件
RUN apt-get update && apt-get upgrade -y \
    && apt-get install git -y \
    && apt-get install ssh -y \
    && git config --global user.name "leonasansei" \
    && git config --global user.email leonasansei@qq.com \
    && useradd -m git\
    && su - git -c "git init --bare /home/git/blog.git" 
# 复制
COPY ./personconf/.ssh/authorized_keys /home/git/.ssh/authorized_keys
COPY ./personconf/post-receive /home/git/blog.git/hooks/post-receive
RUN chown -R git:git /home/git/.ssh \
    && chown -R git:git /usr/share/nginx/html \
    && chown -R git:git /home/git/blog.git \
    && su - git -c "chmod +x /home/git/blog.git/hooks/post-receive" \
    && sed -i "s/git:x:1000:1000::\/home\/git:\/bin\/sh/git:x:1000:1000::\/home\/git:\/usr\/bin\/git-shell/g" /etc/passwd 