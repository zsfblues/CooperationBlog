package com.zsf.dao;

import com.zsf.interfaces.Submit;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.dao
 * @ 2015/10/18
 */

/*
    @ 策略模式的上下文类
 */
public class SubmitContext<T>
{
    private Submit submit;
    private T object;

    public SubmitContext(Submit submit, T object)
    {
        this.submit = submit;
        this.object = object;
    }

    public boolean ContextSubmit(String name)
    {
        return this.submit.checkInfoFormat(object) && this.submit.isRepeatSubmit(name);
    }
}
