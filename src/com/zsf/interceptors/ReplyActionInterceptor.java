package com.zsf.interceptors;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.ServletActionContext;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.interceptors
 * @ 2015/10/22
 */
public class ReplyActionInterceptor extends AbstractInterceptor
{
    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception
    {
        String requestURI = ServletActionContext.getRequest().getRequestURI();
        int index = requestURI.lastIndexOf(".");
        int index1= requestURI.lastIndexOf("/");

        if ("reply".equals(requestURI.substring(index1 + 1, index)))
        {
            return "stop_reply";
        }

        return actionInvocation.invoke();
    }
}
