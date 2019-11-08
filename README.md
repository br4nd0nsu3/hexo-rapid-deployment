# 实现hexo博客的快速部署docker

为了方便~~媳妇~~搭建属于自己的hexo博客，而且网上没有找到符合自己想法的docker-compose文件，所以写了这个dockerfile。

## Attention

>由于至今没弄明白git config的user.name和user.email的作用。这块也是按照他人教程进行修改，所以在进行部署的时候还是修改下dockerfile中的user.name以及user.email吧，保持公钥名字和user.email一致。

根据**user.email**生成公私钥对的命令如下

```bash
ssh-keygen -t rsa -C "<useremail>"
```

## 使用方法

先修改自己的.ssh文件夹下authorized_keys的内容，设置为自己的公钥。
利用命令

```bash
ssh-add <your ida_rsa>
```

添加自己的私钥。

和docker-compose一样，将项目上传到自己的vps或者电脑上，可以修改docker-compose.yml文件中暴露的端口。

执行

```bash
docker-compose up
```

## 本机需要的操作

### 安装hexo

[hexo链接](https://hexo.io/zh-cn/docs/)

### 生成博客

```bash
hexo init <yourblog>
cd <yourblog>
# 安装git发布插件
npm install --save hexo-deployer-git
```

### 修改_config.yml文件

```yml
deploy:
type: git
repo: ssh://git@<ip>:<port>/home/git/blog.git
branch: master
```

### 生成博客并发布

```bash
# 生成静态文件
hexo g
# 远程发布
hexo d
```

### 后续

后面就是自己更换喜爱的主题，各种前端大佬自行发挥吧。

### 参考文章

[一个教程“Hexo部署到VPS”，留着自用。](https://www.jianshu.com/p/d1f7cfb8ecf0)

[Hexo搭建个人博客并使用Git部署到VPS](https://www.jianshu.com/p/b926ecf1c6f6)

[使用docker搭建nginx挂载hexo博客](https://www.jianshu.com/p/111e3c56ef04)
