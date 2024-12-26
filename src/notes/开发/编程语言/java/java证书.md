
将安全证书导入到java的cacerts证书库
1、下载安全证书
浏览器访问https网站，点击小锁图标->证书->详细信息->保存到文件；
2、导入
keytool -import -alias test -keystore cacerts -file ${JAVA_HOME}/jre/lib/security/test.cer
3、校验
keytool -list -keystore cacerts -alias test



# keytool


keytool JAVA是个密钥和证书管理工具。它使用户能够管理自己的公钥/私钥对及相关证书，用于（通过数字签名）自我认证（用户向别的用户/服务认证自己）或数据完整性以及认证服务。它还允许用户储存他们的通信对等者的公钥（以证书形式）。


-genkey      在用户主目录中创建一个默认文件".keystore",还会产生一个mykey的别名，mykey中包含用户的公钥、私钥和证书
-alias       产生别名
-keystore    指定密钥库的名称(产生的各类信息将不在.keystore文件中
-keyalg      指定密钥的算法   
-validity    指定创建的证书有效期多少天
-keysize     指定密钥长度
-storepass   指定密钥库的密码
-keypass     指定别名条目的密码
-dname       指定证书拥有者信息 例如：  "CN=sagely,OU=atr,O=szu,L=sz,ST=gd,C=cn"
-list        显示密钥库中的证书信息      keytool -list -v -keystore sage -storepass ....
-v           显示密钥库中的证书详细信息
-export      将别名指定的证书导出到文件  keytool -export -alias caroot -file caroot.crt
-file        参数指定导出到文件的文件名
-delete      删除密钥库中某条目          keytool -delete -alias sage -keystore sage
-keypasswd   修改密钥库中指定条目口令    keytool -keypasswd -alias sage -keypass .... -new .... -storepass ... -keystore sage
-import      将已签名数字证书导入密钥库  keytool -import -alias sage -keystore sagely -file sagely.crt
             导入已签名数字证书用keytool -list -v 以后可以明显发现多了认证链长度，并且把整个CA链全部打印出来。