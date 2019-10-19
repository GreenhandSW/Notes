# 1. mysql基础操作

1. 启动`mysql`服务（管理员模式下）：

   ```powershell
   net start mysql
   ```

2. 切换目录：

   ```powershell
   cd ***\bin
   # ***表示mysql的安装路径
   ```

3. 登陆：

   1. 一般：

      ```powershell
      mysql -h 主机名 -u 用户名 -p
      ```

   2. 本机：

      ```powershell
      mysql -u root -p
      ```

4. 退出

   ```mysql
   exit
   # 或
   quit
   ```

   