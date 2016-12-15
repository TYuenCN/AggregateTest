require('UIView, UIColor')
defineClass( 'JSPatchTestRootVC', {
                changeBg:function(){
                    self.view().setBackgroundColor( UIColor.yellowColor() );
                }
            } );
