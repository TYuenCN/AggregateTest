安装 Node.js（其中包含 nam）：
    下载pkg后安装：https://nodejs.org/en/
NPM 换源:
    国内优秀npm镜像：
        搜索地址：http://npm.taobao.org/
        registry地址：http://registry.npm.taobao.org/
    cnpmjs镜像：
        搜索地址：http://cnpmjs.org/
        registry地址：http://r.cnpmjs.org/
    如何使用：
        临时使用：
            npm --registry https://registry.npm.taobao.org install express
        持久使用：
            npm config set registry https://registry.npm.taobao.org
            // 配置后可通过下面方式来验证是否成功
            npm config get registry
            // 或npm info express





服务器搭建：
    安装Watchman和Flow：
    然后创建一个存放代码的目录，比如我的目录是：~/Server/react/AggregateTest
    切换到此目录下，执行下面语句进行初始化设置。
        npm init
    将生成一个 package.json 文件
    修改为类似：
{
  "name": "aggregatetest",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "node_modules/react-native/packager/packager.sh",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "react": "15.4.1",
    "react-native": "0.40.0"
  }
}
    此时，就可以执行以下语句进行下载react了。
        npm install
    会多一个 node_modules 目录
    当安装好后，node_modules 目录 平级目录，创建两个文件：index.ios.js和index.android.js。这是用来测试使用的。
    启动服务，执行如下语句：
    npm start
    尝试访问：
    http://192.168.0.203:8081/index.ios.bundle?platform=ios
    http://192.168.0.203:8081/index.android.bundle?platform=android




iOS 集成：
    在现有工程下，新建目录：ReactNative
    在其中也创建一个上面的 package.json 文件
    执行 npm install
        ReactNative/ 也会多一个 node_modules 目录
    如果不手动运行服务，XCode 调试也会自动弹出一个服务命令行，并启动，所以本地目录也可以添加 ：node_modules 目录 平级目录，创建两个文件：index.ios.js和index.android.js。这是用来测试使用的。
    在工程中，另起一个 Group：ReactNativeLibraries，上右键--> addFiles to "项目名"，选择目录：
        node_modules/react-native/React/React.xcodeproj  或者
        node_modules/react-native/Libraries/Text/RCTText.xcodeproj
    Target -> Edit Scheme... -> Build 下：
        添加 Targets  React
        最上的 Build Option，取消 Parallelize Build
    设置Other Linker Flag, 添加：-ObjC -lc++






发布：
    发布时，我们需要先编译js文件。在服务器中切换到刚刚的目录下（如/var/react/tykReact），执行如下两个命令：
        sudo react-native bundle --minify --entry-file index.ios.js --bundle-output /tmp/ios.jsbundle --platform ios
        sudo react-native bundle --minify --entry-file index.android.js --bundle-output /tmp/android.jsbundle --platform android
    会在/tmp目录下出现两个文件：将这两个文件分别放入到ios项目和android asset目录下
        ios.jsbundle 和 android.jsbundle。




集成错误：
    native module cannot be null
        Group：ReactNativeLibraries，补充添加依赖工程 RCTWebSocket, RCTNetwork, RCTText, React
        工程配置 -> Build Phases -> Link LIbrary .. 添加全了

