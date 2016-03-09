package com.zsf.interfaces;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.interfaces
 * @ 2015/10/17
 */

/*
    @ 策略 抽象接口
 */
public interface Submit<T>
{
    boolean isRepeatSubmit(String name);
    boolean checkInfoFormat(T object);
}
