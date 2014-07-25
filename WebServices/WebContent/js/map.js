function Map() {//初始化map_,给map_对象增加方法，使map_像Map   

         var map_ = new Object();   

         map_.put = function(key, value) {   

             map_[key+'_'] = value;   

         };   

         map_.get = function(key) {   

             return map_[key+'_'];   

         };   

         map_.remove = function(key) {   

             delete map_[key+'_'];   

         };   

         map_.keyset = function() {   

             var ret = "";   

             for(var p in map_) {   

                 if(typeof p == 'string' && p.substring(p.length-1) == "_") {   

                     ret += ",";   

                     ret += p.substring(0,p.length-1);   

                 }   

             }   

             if(ret == "") {   

                 return ret.split(",");   

             } else {   

                 return ret.substring(1).split(",");   

             }   

         };   

         return map_;   

} 
