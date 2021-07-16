#!/bin/sh
#create by 2020-06-19 xiaobai021sdo
#update by 2020-08-10 xiaobai021sdo
#update by 2020-08-20 xiaobai021sdo
#update by 2021-07-16 xiaobai021sdo
#获取当前路径
basedir=$(cd "$(dirname "$0")"; pwd)

#创建配置文件目录
mkdir -p $basedir/plumelog-server/config/

#plumelog-server配置文件写入
cat << EOF >$basedir/plumelog-server/config/application.properties

spring.application.name=plumelog_server
#服务端口号，默认8891,可以根据实际情况改动
server.port=8891
spring.thymeleaf.mode=LEGACYHTML5
spring.mvc.view.prefix=classpath:/templates/
spring.mvc.view.suffix=.html
spring.mvc.static-path-pattern=/plumelog/**

#值为4种 redis,kafka,rest,restServer,redisCluster,redisSentinel
#redis 表示用redis当队列
#redisCluster 表示用redisCluster当队列
#redisSentinel 表示用redisSentinel当队列
#kafka 表示用kafka当队列
#rest 表示从rest接口取日志
#restServer 表示作为rest接口服务器启动
#ui 表示单独作为ui启动
plumelog.model=redis

#如果使用kafka,启用下面配置
#plumelog.kafka.kafkaHosts=172.16.247.143:9092,172.16.247.60:9092,172.16.247.64:9092
#plumelog.kafka.kafkaGroupName=logConsumer

#队列redis地址，集群用逗号隔开，model配置redis集群模式
plumelog.queue.redis.redisHost=127.0.0.1:6379
#如果使用redis有密码,启用下面配置
#plumelog.queue.redis.redisPassWord=123456
#plumelog.queue.redis.redisDb=0

#管理端redis地址
plumelog.redis.redisHost=127.0.0.1:6379
#如果使用redis有密码,启用下面配置
#plumelog.redis.redisPassWord=123456
#plumelog.queue.redis.redisDb=0

#如果使用rest,启用下面配置
#plumelog.rest.restUrl=http://127.0.0.1:8891/getlog
#plumelog.rest.restUserName=plumelog
#plumelog.rest.restPassWord=123456

#redis解压缩模式，开启后不消费非压缩的队列
#plumelog.redis.compressor=true

#elasticsearch相关配置，Hosts支持携带协议，如：http、https
plumelog.es.esHosts=127.0.0.1:9200
#ES7.*已经去除了索引type字段，所以如果是es7不用配置这个，7.*以下不配置这个会报错
#plumelog.es.indexType=plumelog
plumelog.es.shards=5
plumelog.es.replicas=1
plumelog.es.refresh.interval=30s
#日志索引建立方式day表示按天、hour表示按照小时
plumelog.es.indexType.model=day
#ES设置密码,启用下面配置
#plumelog.es.userName=elastic
#plumelog.es.passWord=elastic
#是否信任自签证书
#plumelog.es.trustSelfSigned=true
#是否hostname验证
#plumelog.es.hostnameVerification=false


#单次拉取日志条数
plumelog.maxSendSize=100
#拉取时间间隔，kafka不生效
plumelog.interval=100

#plumelog-ui的地址 如果不配置，报警信息里不可以点连接
plumelog.ui.url=https://127.0.0.1:8891

#管理密码，手动删除日志的时候需要输入的密码
admin.password=123456

#日志保留天数,配置0或者不配置默认永久保留
admin.log.keepDays=30
#链路保留天数,配置0或者不配置默认永久保留
admin.log.trace.keepDays=30
#登录配置，配置后会有登录界面
#login.username=
#login.password=

EOF


echo "请修改$basedir/plumelog-server/config/application.properties 配置文件"

echo "修改完成后启动plumelog-start.sh"
