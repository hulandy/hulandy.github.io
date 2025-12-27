---
title: "Mysql"
date: 2016-11-03
categories: 
  - "linux"
---

**Error: MySQL - mysqldump: Got error: 1016: Can't open file: './exampledb/xxx.frm' (errno: 24) when using LOCK TABLES**  
**Solution:**  
mysqldump -u root -pmysecretpassword --opt exampledb --lock-tables=false > exampledb.sql

**Restore:**

# /usr/local/mysql/bin/mysql -u root -p **\*** myblog < /home/zhangy/blog/database\_bak/myblog.sql

**Or:**  
mysql -u dbadmin -p  
use myblog;  
set names utf8; #这里的字符集根你的将要导入的数据库的字符集一至。  
source /home/zhangy/blog/database\_bak/myblog.sql;

**Table is marked as crashed and should be repaired**  
**Solution:**  
mysqlcheck --repair --all-databases

1、给root加个密码ab12。

```
mysqladmin -u root -password ab12
注：因为开始时root没有密码，所以-p旧密码一项就可以省略了。
```

2、再将root的密码改为djg345。

```
mysqladmin -u root -p ab12 password djg345
```

（注意：和上面不同，下面的因为是MYSQL环境中的命令，所以后面都带一个分号作为命令结束符）

3、命令行修改root密码：

```
mysql> UPDATE mysql.user SET password=PASSWORD(’新密码’) WHERE User=’root’;
mysql> FLUSH PRIVILEGES;
```

4、显示当前的user：  
mysql> SELECT USER();

drop命令用于删除数据库。

drop命令格式：drop database <数据库名>;

例如，删除名为 xhkdb的数据库：  
mysql> drop database xhkdb;

\[例子1\] 删除一个已经确定存在的数据库：  
mysql> drop database drop\_database;  
Query OK, 0 rows affected (0.00 sec)

\[例子2\] 删除一个不确定存在的数据库：

```
mysql> drop database drop_database;
ERROR 1008 (HY000): Can't drop database 'drop_database'; database doesn't exist
// 发生错误，不能删除'drop_database'数据库，该数据库不存在。

mysql> drop database if exists drop_database;
Query OK, 0 rows affected, 1 warning (0.00 sec)
//产生一个警告说明此数据库不存在

mysql> create database drop_database;  // 创建一个数据库
Query OK, 1 row affected (0.00 sec)
mysql> drop database if exists drop_database;  // if exists 判断数据库是否存在，不存在也不产生错误
Query OK, 0 rows affected (0.00 sec)
```

centos 5 安装低版本的mysql 4.0 config报错 Linux thread not found

解决方法 打开文件：  
/usr/include/pthread.h

在文件开头添加  
/ _Linuxthreads_ /

老外：You need to install glibc-devel glibc-headers package  
yum install glibc-devel glibc-headers

Also, linuxthreads is obsoleted and posixthreads should be used instead. You should look at mysql's configure options to switch to pthreads.
