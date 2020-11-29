var cache = function(){};

//定义静态方法
cache.data={
    1:{
        0 : "克",
        1 : "千克"
    },
    2:{
        0 : "塑胶",
        1 : "板材",
        2 : "铜管"
    }
};

/**
 * 获取缓存
 * @param type
 */
cache.get = function(type){
    return cache.data[type];
}

/**
 * 获取缓存明细值
 * @param type
 * @param cacheVal
 * @returns
 */
cache.getName = function(type,cacheVal){
    try {
        return cache.data[type][cacheVal];
    } catch (e) {
        return "--";
    }
}