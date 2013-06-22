class Kernel

   # 公開メソッド一覧取得
   @methods: ->
     methods = []
     for key, val of this
       if @method_exists(key)
         methods.push key

     methods
   # クラス名取得
   @class_name: ->
     match = this.constructor.toString().match(/function\s*(\w+)/)
     match[1]
   
   # 親クラス名を取得
   @superclass: ->
       self = this.constructor.__super__
       self.class_name? && self.class_name()
   
   # 継承関係を配列で取得
   @ancestors: ->
     self = this
     ancestors = []
     ancestors.push @class_name()

     while(self.superclass?)
        superclass = self.superclass()
        if superclass
          ancestors.push superclass 
        
        self = self.constructor.__super__
          
     ancestors          
   
   # 関数の存在確認
   @method_exists: (method_name)->
      typeof(this[method_name]) == "function"

exports.Kernel = Kernel