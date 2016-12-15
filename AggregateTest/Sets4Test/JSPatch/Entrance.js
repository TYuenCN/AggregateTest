//
//
// log console
console.log("JS Log");


//
//
// 在使用Objective-C类之前需要调用 require(‘className’)
// 可以用逗号 , 分隔，一次性导入多个类
// 或者直接在使用时才调用 require() : require('UIView').alloc().init()
require('UIView, UIColor')
require('JSPatchTestRootVC')
require('YUENMediator')
require('NSThread')

//
//
// 添加（覆盖）方法 ＋ 更改背景
//
// classDeclaration:要添加或者重写方法的类名 字符串  如果此类不存在 则会创建新的类
// instanceMethods:要添加或者重写的实例方法 {}
// classMethods:要添加或者重写的类方法 {}
//
// defineClass(classDeclaration, instanceMethods, classMethods)
//
// 1、使用双下划线 __ 代表原OC方法名里的下划线 _
// 2、在方法名前加 ORIG 即可调用未覆盖前的 OC 原方法
// 3、使用 self.super() 接口代表 super 关键字，调用 super 方法
defineClass( 'JSPatchTestRootVC', {
                changeBg:function(){
                    // 调用原始方法内容
                    self.ORIGchangeBg();
                    self.view().setBackgroundColor( UIColor.yellowColor() );
                }
            } );

//
//
// 调用实例方法 ＋ 调用类方法
var vc = YUENMediator.sharedInstance().queryVCWithClass(JSPatchTestRootVC.class());
vc.changeBg();

//
//
// 调用多参数方法
// 1.若原 OC 方法名里包含下划线 _，在 JS 使用双下划线 __ 代替：
vc.callWithArg1_arg2("ArgumentA", "ArgumentB");
vc.setProperty( "PPP" );



//
//
// 动态新增Property
//
// 若要在 JS 为类新增 Property，可以使用 getProp() 和 setProp_forKey() 这两个接口
// 注意 getProp() 无法获取在 OC 定义的 Property，只能获取在 JS 通过 setProp_forKey() 接口设置的 Property
defineClass( 'JSPatchTestRootVC', {
            addP:function(){
            self.setProp_forKey( "NewProperty", "nP" );
            },
            getP:function(){
            console.log(self.getProp("nP"));
            }
            } );
vc.addP();
vc.getP();

//
//
// Struct
// JSPatch原生支持 CGRect / CGPoint / CGSize / NSRange 这四个 struct 类型
var newView = UIView.alloc().initWithFrame({x:10, y:60, width:100, height:100});
newView.setBackgroundColor( UIColor.greenColor() );
vc.view().addSubview(newView);

//
//
// Selector
// 用 OC 的 performSelector:withObject: 方法调用 callFromSelectorWithObject:
vc.performSelector_withObject( 'callFromSelectorWithObject:', "Arg String" );

//
//
// JS 创建新类，带有 Protocol 实现
//
// 可以在定义时让一个类实现某些 Protocol 接口，写法跟 OC 一样
defineClass("JPViewController: UIViewController<UIScrollViewDelegate, UITextViewDelegate>", {
            
            })

//
//
// nil 与 NSNull
// JS 上的 null 和 undefined 都代表 OC 的 nil，如果要表示 NSNull, 用 nsnull 代替:
vc.testNull( null );
vc.testNull( undefined );
vc.testNull( nsnull );

//
//
// NSArray / NSString / NSDictionary
//
// 1、NSArray / NSString / NSDictionary 不会自动转成对应的JS类型，像普通 NSObject 一样使用它们
// 2、如果要把 NSArray / NSString / NSDictionary 转为对应的 JS 类型，使用 .toJS() 接口
var ocStr = vc.array().objectAtIndex( 0 );
ocStr.appendString( " -- Add::\"JS Patch\"" );
console.log( ocStr );

var ocDict = vc.dict();
ocDict.setObject_forKey( "TsengYuen", "Name" );
ocDict = ocDict.toJS();
ocDict['age'] = 33;
console.log( ocDict );

//
//
// Block
//
// 1、当要把 JS 函数作为 block 参数给 OC时，需要先使用 block(paramTypes, function) 接口包装
// 2、从 OC 返回给 JS 的 block，直接调用即可
// 3、在 block 里无法使用 self 变量，需要在进入 block 之前使用临时变量保存它
// 4、从 JS 传 block 到 OC，有两个限制：A. block 参数个数最多支持4个。（若需要支持更多，可以修改源码）B. block 参数类型不能是 double。
vc.request( block("NSString *, BOOL", function(ctn, succ){
                  console.log( ctn );
                  }) );

var ocBlock = vc.genBlock();
ocBlock({'name':'YUEN'});

//
//
// __weak / __strong
//
// 可以在 JS 通过 __weak() 声明一个 weak 变量，主要用于避免循环引用。
// 若要在使用 weakSelf 时把它变成 strong 变量，可以用 __strong() 接口
defineClass( 'JSPatchTestRootVC', {
            tstFunc:function(){
            var slf = self;
            var wslf = __weak(self);
            var sslf = __strong(self);
            var b = block("NSString *, BOOL", function(ctn, succ){
                          console.log( slf );
                          console.log( wslf );
                          console.log( sslf );
                          });
            self.request( b );
            }});

vc.tstFunc();

//
//
// 使用 dispatch_after() dispatch_async_main() dispatch_sync_main() dispatch_async_global_queue() 接口调用GCD方法
dispatch_async_main( function(){
                    console.log( "dispatch_async_main print." );
                    });
dispatch_sync_main( function(){
                    console.log( "dispatch_sync_main print." );
                   });
dispatch_after( 10.0, function(){
               console.log( "dispatch_after print." );
               console.log( NSThread.currentThread() );
               }
               );
dispatch_async_global_queue( function(){
                            console.log( "dispatch_async_global_queue print." );
                            console.log( NSThread.currentThread() );
                            });
