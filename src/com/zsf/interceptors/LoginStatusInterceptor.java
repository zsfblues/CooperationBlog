package com.zsf.interceptors;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import org.apache.struts2.ServletActionContext;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.interceptors
 * @ 2015/10/18
 */
public class LoginStatusInterceptor extends AbstractInterceptor
{

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception
    {
        if (ServletActionContext.getRequest().getSession().getAttribute("user") == null)
        {
            return "login";
        }

        return actionInvocation.invoke();
    }
}
